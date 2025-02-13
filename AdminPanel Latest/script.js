//Api Intigretion

const bU = 'http://192.168.253.77:8080';
const ep = {
    'lgn': '/LoginAdmin',
    'gfd': '/GetFormDetails',
    'afo': '/AdmitForm',
    'sfo': '/SubmitForm',
    'ufo': '/UpdateForm',
    'gfi': '/GetFormId',
    'cfi': '/CheckFormId',
    'gcs': '/GetCources',
    'gfs': '/FormStatus'
};


// Read Url Parameter's to perform various actions!!

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const action = urlParams.get('action');
var ExtraParam = "";

if (urlParams.get('action')) {
    if (action === "logout") {
        localStorage.removeItem("AUTHNEW") // to remove authorization
        window.location = 'index.html';
    } else if (action === "stsess") {
        ExtraParam = urlParams.get('AUTHNEW');
        localStorage.setItem("AUTHNEW", ExtraParam);// to add authorization
        window.location = 'index.html';

    } else {
        console.log(action);
    }
}


//Check authorized or not
var loc = window.location

if (localStorage.getItem('AUTHNEW')) {
    //Code to perform after authorised
    if(!loc.toString().toLowerCase().includes('frmsbm.html')){
        window.location = 'frmsbm.html'
    }
} else {
    //Code to perform if not authorised
    if(loc.toString().toLowerCase().includes('frmsbm.html')){
        window.location = 'index.html'
    }
}
