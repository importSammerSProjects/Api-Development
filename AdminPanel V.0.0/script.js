//Api Intigretion

const bU = 'http://127.0.0.1:8080';
const ep = {
    'lgn':'/LoginAdmin',
    'gfd':'/GetFormDetails',
    'afo':'/AdmitForm',
    'sfo':'/SubmitForm',
    'ufo':'/UpdateForm',
    'gfi':'/GetFormId',
    'cfi':'/CheckFormId',
    'gcs':'/GetCources',
    'gfs':'/FormStatus'
};


// Read Url Parameter's to perform various actions!!

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const action = urlParams.get('action');
var ExtraParam = "";

if(urlParams.get('action')){
    if(action === "logout"){
        localStorage.removeItem("AUTHNEW") // to remove authorization
        window.location = 'index.html';
    }else if(action === "stsess"){
        ExtraParam = urlParams.get('AUTHNEW');
        localStorage.setItem("AUTHNEW", ExtraParam);// to add authorization
        window.location = 'index.html';
        
    }else{
        console.log(action);
    }
}


//Check authorized or not

if (localStorage.getItem('AUTHNEW')) {
    console.log("Authorized");//Code to perform after authorised
} else {
    console.log("Authorization Required!");//Code to perform if not authorised
}


// Login for AUTHNEW key Using Api

fetch('http://127.0.0.1:8080/LoginAdmin').then(responce =>responce.json()).then(data =>{
    console.log(data)
})

console.log(bU+ep.lgn)
