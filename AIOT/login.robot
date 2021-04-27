*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${host}           https://aims.qat.askeycloudapi.com
&{login_headers}    Content-Type=application/json; charset=utf-8    x-client-id=46bf882df2959ea2
${hash}           1619061176908;abcdefg;4be93087af6567e0b2bf283e90fded3a1d71dbcebca1a966e5bc20ce588605ff

*** Keywords ***
获取token
    [Arguments]    ${name}    ${password}
    create session    login    ${host}
    ${accout_name}    Set variable    {"account_name": "${name}", "user_name": "${name}", "hashed_password": "${password}"}
    ${data}    post request    login    /v1/auth/users/login    headers=&{login_headers}    data=${accout_name}
    ${data_token}    Set variable    ${data.json()}
    ${gettoken}    get from dictionary    ${data_token}    access_token
    ${get_apikey}    get from dictionary    ${data_token}    x_api_key
    ${getheaders}    create dictionary    x-api-key=${get_apikey}    Authorization=Bearer ${gettoken}    Content-Type=application/json; charset=utf-8    x-key-hash=${hash}
    [Return]    ${getheaders}

获取header
    ${headers}    获取token    nene2    27cc6994fc1c01ce6659c6bddca9b69c4c6a9418065e612c69d110b3f7b11f8a
    [Return]    ${headers}
