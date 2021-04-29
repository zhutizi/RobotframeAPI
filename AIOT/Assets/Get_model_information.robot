*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          ../login.robot

*** Test Cases ***
normal
    create session    model    https://aiot.qat.askeycloudapi.com
    ${ab}    获取header
    ${CDR}    get request    model    /v1/assets/model/CDR8010    headers=${ab}
    ${rep_model}    get from dictionary    ${CDR.json()}    model
    should be equal as strings    ${rep_model}    CDR8010

*** Keywords ***
