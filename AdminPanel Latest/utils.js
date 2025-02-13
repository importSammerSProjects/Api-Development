//Require Variables
let studname = document.querySelector('#studname');
let studage = document.querySelector('#studage');
let studadhr = document.querySelector('#studadhr');
let studcou = document.querySelector('#studcou');
let studstat = document.querySelector('#studstat');
let fid = document.querySelector('#fid');
let loader = document.querySelector('#loadera1');
// loader.style.display = 'none';



//Get Form Id

function GetFormId() {
    fetch(bU + ep.gfi, {
        mode: 'cors',
        headers: {
            "AUTHNEW": localStorage.getItem('AUTHNEW')
        }
    })
        .then(responce => {
            if (responce.status == 400) {
                alert('Authorization Required!')
            }
            return responce.json()
        })
        .then(data => {
            clAll()
            console.log(data)
            fid.value = data.FormId
            loader.style.display = 'none';
        })
}
GetFormId()





// Function For Making InputsEmpty
function clAll() {
    studname.value = ''
    studage.value = ''
    studadhr.value = ''
    studcou.value = ''
    studstat.value = ''

}
clAll()


// Get Form Details
function FormDetails(fid) {
    loader.style.display = 'block';
    fetch(bU + ep.gfd, {
        method: "post",
        mode: 'cors',
        body: JSON.stringify({
            "FormId": fid
        }),
        headers: {
            "AUTHNEW": localStorage.getItem('AUTHNEW')
        }
    })
        .then(responce => {
            if (responce.status == 400) {
                alert('Authorization Required!')
            }
            return responce.json()
        })
        .then(data => {
            clAll()
            console.log(data)
            studname.value = data[1].Name
            studage.value = data[1].Age
            studadhr.value = data[1].AdhaarId
            studcou.value = data[1].Course
            studstat.value = data[1].Status
            loader.style.display = 'none';
        })
        GetFormId();
}

const getdetl = document.querySelector('#formdetl')

getdetl.addEventListener('click', event => {
    if (fid.value) {
        FormDetails(fid.value)
    }else{
        alert('Please Input FormId')
    }
})




//Submit Form
function SubmitForm(n, c, a, p, a2) {
    loader.style.display = 'block';
    fetch(bU + ep.sfo, {
        method: "POST",
        body: JSON.stringify({
            "Name": n,
            "Course": c,
            "AdhaarId": a,
            "Pic": p,
            "Age": a2
        })
    })
        .then(responce => {
            if (responce.status == 400) {
                alert('Authorization Required!')
            }
            return responce.json()
        })
        .then(data => {
            console.log(data)
            fid.value = data.FormId
            alert('Form Submitted!!')
            clAll()
            loader.style.display = 'none';
            GetFormId();
        })
}



const sbmitn = document.querySelector('#submitn')

sbmitn.addEventListener('click', event => {

    if (studcou.value && studadhr.value && studage.value && studname.value) {
        SubmitForm(studname.value, studcou.value, studadhr.value, 'none', studage.value)
    } else {
        alert('Please fill all Details!')
    }
})


// Update Form Details
function UFormDetails(fid, n, c, a, p, a2) {
    loader.style.display = 'block';
    fetch(bU + ep.ufo, {
        method: "POST",
        body: JSON.stringify({
            "FormId":fid,
            "Name": n,
            "Course": c,
            "AdhaarId": a,
            "Pic": p,
            "Age": a2
        }),
        headers: {
            "AUTHNEW": localStorage.getItem('AUTHNEW')
        }
    })
        .then(responce => {
            if (responce.status == 400) {
                alert('Authorization Required!')
            }
            return responce.json()
        })
        .then(data => {
            alert(data.Status)
            FormDetails(data.FormId)
            loader.style.display = 'none';
            GetFormId();
        })
}

const updtfrm = document.querySelector('#updtf')

updtfrm.addEventListener('click', event => {

    if (fid.value && studcou.value && studadhr.value && studage.value && studname.value) {
        UFormDetails(fid.value, studname.value, studcou.value, studadhr.value, 'none', studage.value)
    } else {
        alert('Please fill all Details!')
    }
})

// Admit Form
function AdmitForm(fid) {
    loader.style.display = 'block';
    fetch(bU + ep.afo, {
        method: "POST",
        mode: 'cors',
        body: JSON.stringify({
            "FormId": fid
        }),
        headers: {
            "AUTHNEW": localStorage.getItem('AUTHNEW')
        }
    })
        .then(responce => {
            if (responce.status == 400) {
                alert('Authorization Required!')
            }
            return responce.json()
        })
        .then(data => {
            console.log('Admit Form : '+data)
            alert(data.Status)
            FormDetails(data.FormId)
            loader.style.display = 'none';
            GetFormId();
        })
}

const admtf = document.querySelector('#admtf')

admtf.addEventListener('click', event => {
    if (fid.value) {
        AdmitForm(fid.value)
    }else{
        alert('Please Input FormId')
    }
})