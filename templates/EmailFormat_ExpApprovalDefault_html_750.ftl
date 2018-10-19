<#assign expense = model.data.emailData >
<#assign HTML_SPACE = "&nbsp;" >
<#assign BLANK = "" >
<#assign DUMMY_ARRAY = [] >
<#assign commonPrefix = 'expense.email.'>
<#assign keyPrefix = 'text.'>
<#assign itemTypePrefix = 'itemtype.'>

<#compress>

<#include "templates/EmailFormat_ExpApprovalDefault_functions_750.ftl">
<html>
    <head>
        <meta name="x-apple-disable-message-reformatting">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta content="telephone=no" name="format-detection">
        <style>
            body {
                margin: 0;
                font-family: "Arial";
                font-family: "Open Sans", "OpenSans", "opensans", "Sans Serif", "SansSerif", sans-serif, "Arial";
            }
            table.desktopHiddenTable{
                display: none !important; 
                font-size: 0 !important; 
                mso-hide:all !important;
                width:0px !important;
                overflow:hidden !important;
                max-height:0px !important;
                height:0 !important;
                line-height:0 !important;
                margin:0 auto !important;
              	padding-top: 0 !important;
              	padding-bottom: 0 !important;
            }
            td.desktopHiddenData {
                display: none !important; 
                font-size: 0 !important; 
                mso-hide:all !important;
                width:0px !important;
                overflow:hidden !important;
                max-height:0px !important;
                height:0 !important;
                line-height:0 !important;
                margin:0 auto !important;
              	padding-top: 0 !important;
              	padding-bottom: 0 !important;
            }
            tr.desktopHiddenRow {
                display: none !important; 
                font-size: 0 !important; 
                mso-hide:all !important;
                width:0px !important;
                overflow:hidden !important;
                max-height:0px !important;
                height:0 !important;
                line-height:0 !important;
                margin:0 auto !important;
              	padding-top: 0 !important;
              	padding-bottom: 0 !important;
            }
            @media only screen and (max-width:768px) {
                .btn {
                    font-size: 16px !important;
                    font-weight: 400 !important;
                }
            }
            @media only screen and (max-width:480px),
                    only screen and (resolution: 4dppx) and (max-width: 1440px) {
                table.mobileHiddenTable {
                    display: none !important; 
                    font-size: 0 !important; 
                    mso-hide:all !important;
                    width:0px !important;
                    overflow:hidden !important;
                    max-height:0px !important;
                    height:0 !important;
                    line-height:0 !important;
                    margin:0 auto !important;
                    padding-top: 0 !important;
                    padding-bottom: 0 !important;
                }
                table.desktopHiddenTable {
                    display: table !important; 
                    font-size: initial !important; 
                    mso-hide: none !important;
                    width: 100% !important;
                    overflow: auto !important;
                    max-height: initial !important;
                    height: initial !important;
                    line-height: initial !important;
                    margin: 0 !important;
                    padding: 0 !important;
                }
                tr.desktopHiddenRow {
                    display: table-row !important; 
                    font-size: initial !important; 
                    mso-hide: none !important;
                    width: initial !important;
                    overflow: auto !important;
                    max-height: initial !important;
                    height: initial !important;
                    line-height: initial !important;
                    margin: 0 auto !important;
                    padding: initial !important;
                }
                td.desktopHiddenData {
                    display: table-cell !important; 
                    font-size: initial !important; 
                    mso-hide: none !important;
                    width: initial !important;
                    overflow: auto !important;
                    max-height: initial !important;
                    height: initial !important;
                    line-height: initial !important;
                    margin: 0 auto !important;
                    padding: 12px 4px 12px 10px !important;
                }
                table.desktopHiddenTable td{
                    padding: 2px 0 7px;
                }
                .desktopHidden {
                    display: block !important;
                }
                .mobileHidden {
                    display: none !important; 
                    font-size: 0 !important; 
                    mso-hide:all !important;
                    width:0px !important;
                    overflow:hidden !important;
                    max-height:0px !important;
                    height:0 !important;
                    line-height:0 !important;
                    margin:0 auto !important;
                    padding-top: 0 !important;
                    padding-bottom: 0 !important;
                }
                .spanDesktopHidden {
                    display: inline !important;
                }
                .actions {
                    padding: 24px 0 !important;
                }
                .actions table td {
                    width: 164px;
                    padding: initial;
                    height: 40px;
                }
                .btn {
                    font-size: 12px !important;
                    margin-top: 5px;
                    font-weight: 700;
                }
                .head {
                    text-align: left !important;
                }
                .head .logo {
                    display: none !important; 
                    font-size: 0 !important; 
                    mso-hide:all !important;
                    width:0px !important;
                    overflow:hidden !important;
                    max-height:0px !important;
                    height:0 !important;
                    line-height:0 !important;
                    margin:0 auto !important;
                    padding-top: 0 !important;
                    padding-bottom: 0 !important;
                }
                .head .mobileLogo {
                    display: inline !important;
                    mso-hide: none !important
                }
                .head .title {
                    font-size: 24px;
                }
                .head .subText {
                    font-size: 18px;
                    line-height: 18px !important;
                }
                h2 {
                    padding: 0 !important;
                    font-size: 18px !important;
                }
                table.summaryTable {
                    padding: 12px 6px !important;
                }
                .summaryTable td {
                    font-size: 16px;
                }
                .summaryTable-currencyRow {
                    width: initial !important;
                }
                .summaryTable-totalAmount {
                    font-size: 20px !important;
                }
                .mobileMaxColumn {
                    max-width: 100px;
                }
                .actions {
                    text-align: center;
                }
                .footer-actions {
                    width: 100%;
                }
                .footer-actions .btns td {
                    display: block !important;
                    width: 200px !important;
                    margin: 7px auto !important;
                    padding: 13px 0 !important;
                }
                table.body-header {
                    padding: 0 !important;
                    margin: 0 !important;
                }
                table.body-header td {
                    display: block;
                    text-align: left !important;
                    margin: 5px 0;
                }
                table.complianceWarning {
                    padding: 0 !important;
                }
            }
        </style>
    </head>
    <body>
        <div align="center" class="container" style="max-width: 800px; margin: 0 auto;">
            <div style="width: 100%; margin:0; padding: 0; background-color: #367f18; background: -moz-linear-gradient(left, #367f18, #5cc73c); background: -webkit-linear-gradient(left, #367f18, #5cc73c); background: linear-gradient(to right, #367f18, #5cc73c); -webkit-clip-path: polygon(0 0, 100% 0, 100% 100%, 0 90%); clip-path: polygon(0 0, 100% 0, 100% 100%, 0 90%);">
            <!--[if mso]>
            <v:rect xmlns:v="urn:schemas-microsoft-com:vml" fill="true" stroke="false" style="mso-width-percent:1000" fillcolor="#5cc73c">
                <v:fill type="gradient" color2="#367f18" angle="90"/>
                <v:textbox style="mso-fit-shape-to-text:true" inset="0,0,0,0">
                    <center>
            <![endif]-->
            <table class="head" >
                <tr style="font-size: 28px; font-family: Arial; font-weight: 600; text-align: center; padding: 12px; color: rgb(255, 255, 255); margin: 12px 0px;">
                    <td>
                        <@writeHeader/>
                    </td>
                </tr>
            </table>
            <!--[if mso]>
                    </center>
                </v:textbox>
            </v:rect> 
            <![endif]-->
            </div>
            <!--[if gt mso 15]>
            <v:shape style='margin: 0; padding: 0;top: 0; left: 0; mso-width-percent:1000' stroke="false" fill="true" fillcolor="#5cc73c" coordorigin="0 0">
                <v:fill type="gradient" color1="5cc73c" color2="#367f18" angle="90"/>
                <v:path v="m 0,-10
            l 1000,-10,1000,200
            x e"/>
            </v:shape>
            <![endif]-->
            <table class="summary" style="max-width: 800px">
                <tr>
                    <td align="left" style="font-size: 28px; line-height: 32px; color: rgb(74, 74, 74); font-weight: 400; padding: 0px 24px; margin: 12px 0px;">
                        ${writeTitle(expense.expenserowdata)}
                    </td>
                </tr>
                <tr>
                    <td class="subText" style="font-size: 12px; font-weight: 600; color: rgb(74, 74, 74); padding: 0px 24px;">
                        ${replaceWithConstant("Expense ID")}: ${expense.reportId!BLANK}
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="body-header" style="width: 100%; padding: 0px 20px; margin: 12px 0px;">
                            <tbody>
                                <tr class="border-none">
                                    <td>${expense.firstName} ${expense.lastName}</td>
                                    <td align="right" class="textRight" style="text-align: right;">${expenseDates(expense.expenserowdata)}</td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <#if expense.complianceWarningItems?? && expense.complianceWarningItems?has_content >
                    <#list expense.complianceWarningItems as item>
                        <#if item?? && item?has_content>
                            <@writeCompliancewarning/>
                            <#break>
                        </#if>
                    </#list>
                </#if>
                <tr>
                    <td style="padding: 5px 24px 0px">
                        <#if expense.instructionsURL?? && (expense.instructionsURL?length>0)>
                            <a href="${expense.instructionsURL}">${replaceWithConstant('Click Here')}</a>
                        <#else>
                            <a href="https://app.chromeriver.com">${replaceWithConstant('Click Here')}</a>
                        </#if>
                        
                    </td>
                </tr>
                <#if expense.expensesummary?? && expense.expensesummary?has_content >
                    <@writeSummaries name="${replaceWithConstant('Summary by Expense Category')}" listdata=expense.expensesummary!DUMMY_ARRAY summary=expense.financialsummary!DUMMY_ARRAY />
                </#if>
                <#if expense.accountsummary?? && expense.accountsummary?has_content >
                    <@writeExpenseaccountsummary name="${replaceWithConstant('Summary by Allocation')}" listdata=expense.accountsummary!DUMMY_ARRAY summary=expense.financialsummary!DUMMY_ARRAY />
                </#if>
                <#if expense.expensedetailsItems?? && expense.expensedetailsItems?has_content >
                    <@writeExpensedetails_ name="${replaceWithConstant('Expense Line Items')}" expensedetails_=expense.expensedetailsItems!DUMMY_ARRAY summary=expense.financialsummary!DUMMY_ARRAY listdataComplianceWarnings=expense.complianceWarningItems!DUMMY_ARRAY listdataReceipts=expense.lineItemImagesPageIndexeURLs!DUMMY_ARRAY button=expense.button!DUMMY_ARRAY />
                </#if>
                <tr>
                    <@bottomButtons button=expense.button!DUMMY_ARRAY />
                </tr>
                <tr style="text-align: center" align="middle">
                    <td>
                    <#if expense.instructionsURL?? && (expense.instructionsURL?length>0)>
                        <a href="${expense.instructionsURL}">${replaceWithConstant('Click Here')}</a>
                    <#else>
                        <a href="https://app.chromeriver.com">${replaceWithConstant('Click Here')}</a>
                    </#if>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>
</#compress>