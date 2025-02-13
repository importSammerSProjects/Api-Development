from flask import Flask, jsonify, request, render_template
from flask_cors import CORS
import json
import mysql.connector

DB = mysql.connector.connect(host='localhost', user='root', passwd='', database='aams')
cr = DB.cursor(dictionary=True)


app = Flask(__name__)
CORS(app)
def _auth(Oauth):
    cr.execute("""SELECT AUTHNEW FROM Admin WHERE AUTHNEW = %s""", (Oauth,))
    res = cr.fetchone()
    if not Oauth:
        return False
    elif not res:
        return False
    else:
        return True


@app.route('/', methods=['GET', 'POST'])
def home():
        return jsonify({'Status': 'Welcome To AAMS : Advance Admission Management System'
                        ,'Author':'Sameer Najir Sayyed'}), 200

# Admin Login End-Point
@app.route('/LoginAdmin', methods=['GET', 'POST'])
def admin():
    if (request.method == 'GET'):
        return jsonify({'Status': 'Logged In Failed!',
                        'AUTHNEW': '',
                        'Code': '400'}), 400
    else:
        login_Creds = json.loads(request.data)
        Id = login_Creds['Id']
        pw = login_Creds['Pass']
        cr.execute("""SELECT AdminId, Password, AUTHNEW FROM Admin WHERE AdminID = %s""", (Id,))

        res = cr.fetchone()

        if (res['Password'] == pw):
            Oatuh = res['AUTHNEW']
            return jsonify({'Status': 'Logged In Successfully!',
                            'AUTHNEW': f'{Oatuh}',
                            'Code': '200'}), 200

        return jsonify({'Status': 'Try Again!',
                        'Code': '400'}), 400

# Submit Form End-Point
@app.route('/SubmitForm', methods=['POST'])
def submit():
    print(request.headers)
    print(json.loads(request.data))
    cr.execute("""SELECT FormId FROM Forms ORDER BY Id DESC LIMIT 1;""")
    res = cr.fetchone()['FormId']
    sformid = res + 1
    sstat = "Pending"
    smaseg = "Please Visit College!!"
    sfee = "00"
    try:
        FormD = json.loads(request.data)
        sname = FormD['Name']
        scourse = FormD['Course']
        sadhaar = FormD['AdhaarId']
        spic = FormD['Pic']
        sage = FormD['Age']
    except Exception as exc:
        return jsonify({'Status': 'Form Cant be submitted! Please Enter Propper data',
                        'Code': '400'}), 400
    cr.execute(
        """INSERT INTO Forms (FormId, Name, Course, Status, Message, AdhaarId, Pic, Age, Fee) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);""",
        (sformid, sname, scourse, sstat, smaseg, sadhaar, spic,
         sage, sfee,))
    DB.commit()
    cr.execute("""SELECT FormId FROM Forms ORDER BY Id DESC LIMIT 1;""")
    res = cr.fetchone()['FormId']
    return jsonify({'Status': 'Form Submitted!',
                        'FormId': f"{res}",
                        'Code': '200'}), 200


# Get ID For Form End-Point
@app.route('/GetFormId', methods=['GET','POST'])
def getformid():
    cr.execute("""SELECT FormId FROM Forms ORDER BY Id DESC LIMIT 1;""")
    res = cr.fetchone()['FormId']
    return jsonify({'Status': 'Id Fetched Successfully!!',
                        'FormId': f'{res+1}',
                        'Code': '200'}), 200
# Check ID Available Or Used End-Point
@app.route('/CheckFormId', methods=['GET','POST'])
def checkformid():
    try:
        ckD = json.loads(request.data)
        ckId = ckD['FormId']
        cr.execute("""SELECT * From Forms WHERE FormId = %s""", (str(ckId),))
        re1 = cr.fetchone()
        if not re1:
            return jsonify({'Status': 'Id Can Be used!',
                            'FormId': f'{ckId}',
                            'Code': '200'}), 200

        cr.execute("""SELECT * From Forms WHERE FormId = %s""", (str(ckId),))
        res = cr.fetchone()['FormId']
        if str(res) == str(ckId):
            return jsonify({'Status': 'Id Found Already!!',
                            'FormId': f'{ckId}',
                            'Code': '400'}), 400
        else:
            return jsonify({'Status': 'Id Can Be used!',
                            'FormId': f'{ckId}',
                            'Code': '200'}), 200
    except Exception as exc:
        return jsonify({'Status': f'Server Error! : {exc}','Code': '400'}), 400

# Admit Form End-Point
@app.route('/AdmitForm', methods=['POST'])
def admit():
    try:
        admD = json.loads(request.data)
        fid = admD['FormId']
        auth = request.headers.get('AUTHNEW', None)
        if not auth:
            return jsonify({'Status': 'Authorization Header Required!!',
                            'Code': '400'}), 400
        if _auth(auth):
            cr.execute("""SELECT * FROM Admin WHERE AUTHNEW = %s""", (auth,))
            admin = cr.fetchone()['Name']
            cr.execute("""SELECT * FROM Forms WHERE FormId = %s""", (fid,))

            res = cr.fetchone()

            cr.execute(
                """INSERT INTO Admit (FormId, Name, Course, Status, Message, AdhaarId, Pic, Age, Fee, AdmitBy) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
                (res['FormId'], res['Name'], res['Course'], res['Status'], res['Message'], res['AdhaarId'], res['Pic'],
                 res['Age'], res['Fee'], admin))
            DB.commit()
            cr.execute("""UPDATE Forms SET Status = 'Admitted' WHERE FormId = %s;""",(fid,))
            DB.commit()

        else:
            return jsonify({'Status': 'Authorization Required!!',
                            'Code': '400'}), 400

    except Exception as exc:
        return jsonify({'Status': f'Server Error : {exc}',
                        'Code': '400'}), 400


    return jsonify({'Status': 'Form Admitted!',
                        'FormId': f'{fid}',
                        'Code': '200','By': f'{auth}'}), 200



# Cources Detail End-Point
@app.route('/GetCources', methods=['GET', 'POST'])
def Cources():
    cr.execute("""SELECT Course, Fee FROM Course""")

    res = cr.fetchall()
    return jsonify({'Status': 'Cources Detail Fetched!',
                            'Code': '200'}, json.loads(json.dumps(res))), 200

# Check Form Status (Accepted OR Canceled OR Pending
@app.route('/FormStatus', methods=['POST'])
def checkstat():
    print(request.headers)
    print(json.loads(request.data))
    try:
        fsD = json.loads(request.data)
        fid = fsD['FormId']
        cr.execute("""SELECT * FROM Forms WHERE FormId = %s""",(fid,))
        res = cr.fetchone()['Status']
        return jsonify({'Status': f'{res}',
                        'FormId': f'{fid}',
                        'Code': '200'}), 200
    except Exception as exc:
        return jsonify({'Status': 'Form Not Found!',
                        'FormId': f'{fid}',
                        'Code': '400'}), 400



# Get Form Details End-Point
@app.route('/GetFormDetails', methods=['POST'])
def getformdetails():
    UpdationD = json.loads(request.data)
    fid = UpdationD['FormId']
    auth = request.headers.get('AUTHNEW', None)

    cr.execute("""SELECT AUTHNEW FROM Admin WHERE AUTHNEW = %s""", (auth,))

    res = cr.fetchone()

    if _auth(auth):
        cr.execute("""SELECT * FROM Forms WHERE FormId = %s""", (fid,))
        res = cr.fetchone()
        if not res:
            return jsonify({'Status': 'Form Not Found !!',
                            'FormId': f'{fid}',
                            'Code': '400', 'By': f'{auth}'}), 400
        else:
            return jsonify({'Status': 'Form Details Found@',
                            'FormId': f'{fid}',
                            'Code': '200', 'By': f'{auth}'}, json.loads(json.dumps(res))), 200
    else:
        return jsonify({'Status': 'Authorization Required!!',
                        'Code': '400'}), 400

# Update Form End-Point
@app.route('/UpdateForm', methods=['POST'])
def update():
    try:
        FormD = json.loads(request.data)
        auth = request.headers.get('AUTHNEW', None)
        fid = FormD['FormId']
        if not auth:
            return jsonify({'Status': 'Authorization Header Required!!',
                            'Code': '400'}), 400
        if _auth(auth):
            sname = FormD['Name']
            scourse = FormD['Course']
            sadhaar = FormD['AdhaarId']
            spic = FormD['Pic']
            sage = FormD['Age']
            cr.execute("""UPDATE Forms SET Name = %s, Course = %s, AdhaarId = %s, Pic = %s, Age = %s WHERE FormId = %s;""", (sname,scourse,sadhaar,spic,sage,fid))
            DB.commit()
        else:
            return jsonify({'Status': 'Authorization Required!!',
                            'Code': '400'}), 400
        return jsonify({'Status': 'Form Updated!',
                        'FormId': f'{fid}',
                        'Code': '200', 'By': f'{auth}'}), 200
    except Exception as exc:
        return jsonify({'Status': f'Server Error : {exc}',
                        'Code': '400'}), 400



@app.route('/login')
def login():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)