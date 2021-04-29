*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          ../login.robot

*** Test Cases ***
create group
    ${fir}    创建group    CDR80    CDR8010    2345
    log    ${fir}
    ${fir.code}    get from dictionary    ${fir.json()}    code
    should be equal as strings    ${fir.code}    400806

*** Keywords ***
创建group
    [Arguments]    ${series}    ${model}    ${groupname}
    create session    group    https://aiot.qat.askeycloudapi.com
    ${ab}    获取header
    ${data}    set variable    { "series": "${series}", "model": "${model}", "groupname": "${groupname}" }
    ${rep}    post request    group    /v1/assets/group    headers=${ab}    data=${data}
    [Return]    ${rep}
