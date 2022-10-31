function validateName(id) {
    var name = document.getElementById(id).value;

    if (name.length == 0) {
        $('#name-error').removeClass('d-none');
        producePrompt('This field cannot be blank', 'name-error');
        return false;

    } else if (!name.match(/^[A-Za-z ]*/)) {
        $('#name-error').removeClass('d-none');
        producePrompt('Please enter your full name, 'name-error');
        return false;
    } else {
        producePrompt('', 'name-error');
        $('#name-error').addClass('d-none');
        return true;
    }
}

function validatePhone(id) {
    var phone = document.getElementById(id).value;

    if (phone.length == 0) {
        $('#phone-error').removeClass('d-none');
        producePrompt('This field cannot be blank', 'phone-error');
        return false;
    } else if (phone.length < 10) {
        $('#phone-error').removeClass('d-none');
        producePrompt('Incorect format', 'phone-error');
        return false;
    } else if (!phone.match(/^[0-9]{10,11}$/)) {
        $('#phone-error').removeClass('d-none');
        producePrompt('Correct format', 'phone-error');
        return false;
    } else {
        producePrompt('', 'phone-error');
        $('#phone-error').addClass('d-none');
        return true;
    }
}

function validateEmail(id) {
    var email = document.getElementById(id).value;

    if (email.length == 0) {
        $('#email-error').removeClass('d-none');
        producePrompt('This field cannot be blank', 'email-error');
        return false;
    } else if (!email.match(/^[A-Za-z\._\-[0-9]*[@][A-Za-z]*[\.][a-z]{2,4}$/)) {
        $('#email-error').removeClass('d-none');
        producePrompt('Inccorect format', 'email-error');
        return false;

    } else {
        producePrompt('', 'email-error');
        $('#email-error').addClass('d-none');
        return true;
    }
}

function validateAddress(id) {
    var address = document.getElementById(id).value;

    if (address.length == 0) {
        $('#address-error').removeClass('d-none');
        producePrompt('This field cannot be blank', 'address-error');
        return false;
    } else {
        producePrompt('', 'address-error');
        $('#address-error').addClass('d-none');
        return true;
    }
}

function validateForm(idName, idPhone, idEmail, idAddress) {
    if (!validateName(idName)) {
        $('#' + idName).focus();
        return false;
    } else if (!validatePhone(idPhone)) {
        $('#' + idPhone).focus();
        return false;
    } else if (!validateEmail(idEmail)) {
        $('#' + idEmail).focus();
        return false;
    } else if (!validateAddress(idAddress)) {
        $('#' + idAddress).focus();
        return false;
    } else {
        return true;
    }
}

function producePrompt(message, promptLocation) {
    document.getElementById(promptLocation).innerHTML = message;
}