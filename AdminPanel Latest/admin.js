// loader
let loader = document.querySelector('#loadera1');
loader.style.display = 'none';

// Login for AUTHNEW key Using Api
var adminIdVal = document.querySelector('#IdNum').value;
var passwordVal = document.querySelector('#Password').value;

const lgnbtn = document.querySelector('#loginbtn')

lgnbtn.addEventListener('click', event => {
    loader.style.display = 'block';
    adminIdVal = document.querySelector('#IdNum').value;
    passwordVal = document.querySelector('#Password').value;

    if (!adminIdVal || !passwordVal) {
        
        alert('Please Enter All Values')
    }else{
        Login()
    }
})



// Login Function
function Login() {
    loader.style.display = 'block';
    fetch(bU + ep.lgn, {
        method: "POST",
        mode: "cors",
        body: JSON.stringify({ "Id": adminIdVal, "Pass": passwordVal })
    })
        .then(responce => {
            if (responce.status == 400){
                alert('Login Failed !!')
            }
            return responce.json()
        })
        .then(data => {
            loader.style.display = 'none';
            alert('LoggedIn Successfully!')
            window.location = 'index.html?action=stsess&AUTHNEW=' + data.AUTHNEW + '';
        })
}


