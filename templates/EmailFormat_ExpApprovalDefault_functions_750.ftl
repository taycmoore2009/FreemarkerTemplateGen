<#function removeSpecialCharactersAndFormKey var prefix>
	<#if var?? && (var?trim?length>0)>
		<#local temp=var?trim?lower_case?replace('[^a-zA-Z\\d\\s-_]', '', 'r')>
		<#local label = getMessageProperty(commonPrefix+prefix+temp?trim?replace(' +','_','r'))>
		<#if label?contains((commonPrefix+prefix))>
			<#return var>
		<#else>
			<#return label>
		</#if>
	<#else>
		<#return var>
	</#if>
</#function>

<#function checkLabel var prefix>
    <#return commonPrefix+prefix+var?trim?lower_case?replace('[^a-zA-Z\\d\\s-_]', '', 'r')?replace(' +','_','r')>
</#function>

<#function replaceWithConstant var>
	<#return removeSpecialCharactersAndFormKey(var, keyPrefix)>
</#function>

<#function replaceWithConstantForItemType var>
	<#return removeSpecialCharactersAndFormKey(var, itemTypePrefix)>
</#function>

<#function addLabelVar label var>
    <#local index=0>
    <#local filledLabel=label>
    <#list var as str>
        <#local filledLabel=filledLabel?replace("{"+ index?string +"}", str) >
        <#local index=index+1>
    </#list>
    <#return filledLabel>
</#function>

<#macro columnData tdclass="" tdstyle="" data="${HTML_SPACE}">
		<td class="${tdclass}" style="border-width: 1px 0px 0px; border-right-style: initial; border-bottom-style: initial; border-left-style: initial; border-right-color: initial; border-bottom-color: initial; border-left-color: initial; border-image: initial; border-top-style: solid; border-top-color: rgb(162, 162, 162); padding: 12px 4px 12px 10px; ${tdstyle}">
			${data}
		</td>
</#macro>

<#function writeTitle var>
    <#local title="">
    <#list var as row>
        <#if row[0]?contains("Report Name")>
            <#local title=replaceWithConstant("Expense") +": "+ row[1]>
            <#break>
        </#if>
    </#list>
    <#return title>
</#function>

<#function expenseDates var>
    <#local title="">
    <#list var as row>
        <#if row[0]?contains("Expense Dates")>
            <#local title=row[1]>
            <#break>
        </#if>
    </#list>
    <#return title>
</#function>

<#macro writeHeader>
    <table class="desktopHiddenTable" style="display: none; font-size: 0; mso-hide:all;width:0px;overflow:hidden;max-height:0px;height:0;line-height:0;margin:0 auto;padding-top: 0;padding-bottom: 0;">
        <tr>
            <td style="width: 1%; white-space: nowrap;">
                <img class="mobileLogo" src="https://s3.amazonaws.com/chromeriver-cdn-ext-cx-all/css/img/provider_logos/ea_mobile.png" style="width: 35px; vertical-align: middle; padding: 6px 10px 6px 0; margin: 2px 0; border-right: 1px solid #FFF">
            </td>
            <td>
                <span class="title" style="font-size: 24px; color: #FFF; font-family: Arial; font-weight: 600;">
                    ${replaceWithConstant("Expense Portal")}
                </span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <span style="line-height: 44px; color: #FFF" class="subText">
                    ${addLabelVar(replaceWithConstant("Expense Waiting"), [expense.firstName])}
                </span>
            </td>
        </tr>
    </table>
    <table class="mobileHiddenTable" style="margin: 0; margin: 5px 0; width: 100%; text-align:center;" align="center">
        <tr><td></td></tr>
        <tr align="center">
            <td>
                <img class="logo" width="34" height="34" src="https://s3.amazonaws.com/chromeriver-cdn-ext-cx-all/css/img/provider_logos/ea_desktop.png" style="height: 34px; width: 34px; vertical-align: middle;">
                <br class="mobileHidden">
            </td>
        </tr>
        <tr align="center">
            <td>
                <span class="title" style="font-size: 28px; font-family: Arial; font-weight: 300; text-align: center; padding: 12px; color: #FFF;">
                    ${replaceWithConstant("Expense Portal")}
                </span>
                <br/>
            </td>
        </tr>
        <tr align="center">
            <td>
                <span style="line-height: 44px; color: #FFF; font-size: 24px;" class="subText">
                    ${addLabelVar(replaceWithConstant("Expense Waiting"), [expense.firstName])}
                </span>
            </td>
        </tr>
    </table>
</#macro>

<#macro writeCompliancewarning>
    <tr>
        <td>
            <table class="complianceWarning" style="width: 100%; padding: 0px 24px; height: 40px; background-color: rgb(236, 151, 30); font-size: 16px; color: rgb(255, 255, 255);">
                <tbody>
                    <tr class="border-none">
                        <td style="border: 0px; padding: 12px 4px 12px 10px;">
                            ${replaceWithConstant('Compliance Warning')} ${replaceWithConstant('- Details Below')}
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>
    </tr>
</#macro>

<#macro writeSummaries name listdata summary>
	<#if listdata?has_content>
		<#local buf_array=(listdata[0])[1]?split(" ") >
        <#local label="${replaceWithConstant('Amount')} (${expense.currency})">
        <tr>
            <td>
                <table class="summaryTable" cellspacing="0" cellpadding="0" style="width: 100%; padding: 12px 5%; font-size: 16px; color: rgb(42, 42, 42);">
                    <tbody>
                        <tr class="tableHeader">
                            <th align="right" class="textLeft" style="text-align: left; padding: 12px 4px 12px 10px;">
                                ${name}
                            </th>
                            <th align="right" class="textRight summaryTable-currencyRow" style="text-align: right; width: 200px; padding: 12px 4px 12px 10px;">
                                ${label}
                            </th>
                        </tr>
                        <#list listdata as row>
                            <#local currentAmount=row[1]?split(" ") >
                            <tr>
                                <@columnData data="${replaceWithConstant(row[0])!BLANK}" />
                                <@columnData tdstyle="text-align: right" data="${replaceWithConstant(currentAmount[0])!BLANK}" />
                            </tr>
                        </#list>
                    </tbody>
                </table>
                <@summaryTotal listdata=summary extended=true />
            </td>
        </tr>
	</#if>
</#macro>

<#macro writeExpenseaccountsummary name listdata summary>
    <#local label="${replaceWithConstant('Amount')} (${expense.currency})">
    <#local index=1>
	<#if listdata?has_content>
        <tr>
            <td>
                <table class="summaryTable" cellspacing="0" cellpadding="0" style="width: 100%; padding: 12px 5%; font-size: 16px; color: rgb(42, 42, 42);">
                    <tbody>
                        <tr class="tableHeader">
                            <th align="right" class="textLeft" style="text-align: left; padding: 12px 4px 12px 10px;">
                                ${name}
                            </th>
                            <th align="right" class="textRight summaryTable-currencyRow" style="min-width: 75px; text-align: right; width: 200px; padding: 12px 4px 12px 10px;">
                                ${label}
                            </th>
                        </tr>
                        <#list listdata as row>
						    <#if row?? && row[0]?trim != "" && listdata[index]??>
                                <tr>
                                    <#local columnHTML=listdata[index][1]>
                                    <#if listdata[index][2]?trim != "">
                                        <#local columnHTML=columnHTML+', '+ listdata[index][2]>
                                    </#if>

                                    <#local columnHTML=columnHTML +'<br/><span class="subText" style="font-size: 12px; color: rgb(137, 137, 137);">'+ row[0] +'</span>'>
                                    <@columnData data="${replaceWithConstant(columnHTML)!BLANK}" />
                                    <@columnData tdstyle="text-align: right" data="${row[3]?split(' ')[0]!BLANK}" />
                                </tr>
                            </#if>
                            <#local index=index+1>
                        </#list>
                    </tbody>
                </table>
                <@summaryTotal listdata=summary extended=false />
            </td>
        </tr>
	</#if>
</#macro>

<#macro writeExpensedetails_ name expensedetails_ summary listdataComplianceWarnings listdataReceipts button>
    <#local index=0 >
    <#local complianceItem=[] >
    <@midButtons button=button />
    <tr>
        <td style="color: rgb(74, 74, 74);">
            <h2 style="font-size: 28px; font-weight: 100; padding: 0px 24px; margin: 12px 0px;">
                <table style="width: 100%; padding: 0px;">
                    <tbody>
                        <tr>
                            <td style="border: 0px; padding: 0px; font-size: 24px;">${name}</td>
                            <td align="right" class="textRight reciepts" style="border: 0px; padding: 0px; font-size: 14px; text-align: right;">
                                <#if expense.receiptLink?? && expense.hasReportId!false >
                                    <@writeReceiptLink link=expense.receiptLink!BLANK reportIdLabel="${replaceWithConstant('Report ID')}" reportId="${expense.reportId!BLANK}"/>
                                </#if>
                                <#if expense.receiptLink?? && expense.hasPreApprovalIdInHeader!false >
                                    <@writeReceiptLink link=expense.receiptLink!BLANK reportIdLabel="${replaceWithConstant('Pre-Approval ID')}" reportId="${expense.reportId!BLANK}"/>
                                </#if>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </h2>
        </td>
    </tr>
    <tr>
        <td>
            <table class="summaryTable equalWidthTable" cellspacing="0" cellpadding="0" style="width: 100%; padding: 12px 5%; table-layout: fixed; font-size: 16px; color: rgb(42, 42, 42);">
                <tbody>
                    <tr class="tableHeader">
                        <th align="right" class="textLeft" style="width: 110px; text-align: left; padding: 12px 4px 12px 10px;">${replaceWithConstant('Expense Type')}</th>
                        <th align="right" class="textLeft mobileHidden" style="text-align: left; padding: 12px 4px 12px 10px;">${replaceWithConstant('Merchant')}</th>
                        <th align="right" class="textLeft" style="text-align: left; padding: 12px 4px 12px 10px; word-wrap: normal;">${replaceWithConstant('Description')}</th>
                        <th align="right" class="textRight" style="text-align: right; padding: 12px 4px 12px 10px;">${replaceWithConstant('Amount')} (${expense.currency})</th>
                    </tr>
                    <#list expensedetails_ as block>
                        <#if block?? && (block?size gt 0)>
                            <#local isNotParent=true>
                            <#if listdataComplianceWarnings[index]?has_content>
                                <#local complianceItem=listdataComplianceWarnings[index]>
                            <#else>
                                <#local complianceItem=[]>
                            </#if>
                            <#if listdataReceipts?has_content>
                                <#if block[0]?has_content && block[0][0]?lower_case?index_of('child') == -1>
                                    <#if listdataReceipts?size gte index && listdataReceipts[index]?? && listdataReceipts[index] != "">
                                        <#local receiptLink=listdataReceipts[index]!"#">
                                    <#else>
                                        <#local receiptLink="#">
                                    </#if>
                                </#if>
                            </#if>
                            <#list block as args>
                                <#local currSize=0>
                                <#local hasChild=false>
                                <#local trClasses="">
                                <#local trStyles="">
                                <#local hasDesc=false>
                                <#local hasMerch=false>
                                <#if (args?size gt 0)>
                                    <#if args[0]?lower_case?matches('child')>
                                        <#local currSize=(args?size - 1)>
                                        <#local hasChild=true>
                                    <#else>
                                        <#local currSize=args?size>
                                    </#if>
                                    <#if complianceItem?size gt 0>
                                        <#local trClasses="summaryTable-warningRow">
                                        <#local trStyles="background-color: rgb(252, 239, 219);">
                                    </#if>
                                    <#if args[1]?lower_case == "hotel">
                                        <#local isNotParent=false>
                                    </#if>
                                    <#if currSize == 4 && isNotParent && args[0]?trim != "">
                                        <#if complianceItem?has_content>
                                            <#local trClasses="summaryTable-warningRow">
                                            <#local trStyles="background-color: rgb(252, 239, 219);">
                                        </#if>
                                        <tr class="${trClasses}" style="${trStyles}">
                                            <#if receiptLink != "#">
                                                <@columnData data='<a href="${receiptLink}">${replaceWithConstantForItemType(hasChild?then(args[2]!BLANK, args[1]!BLANK))}</a>'/>
                                            <#else>
                                                <@columnData data='<span>${replaceWithConstantForItemType(hasChild?then(args[2]!BLANK, args[1]!BLANK))}</span>'/>
                                            </#if>
                                            <#list block as extras>
                                                <#if extras[0]?lower_case?matches('child')>
                                                    <#if extras?size == 3 && extras[1]?lower_case?matches("merchant")>
                                                        <@columnData data="${replaceWithConstant(extras[2])!BLANK}" tdclass="mobileHidden"/>
                                                        <#local hasMerch=true>
                                                    </#if>
                                                <#else>
                                                    <#if extras?size == 2 && extras[0]?lower_case?matches("merchant")>
                                                        <@columnData data="${replaceWithConstant(extras[1])!BLANK}" tdclass="mobileHidden"/>
                                                        <#local hasMerch=true>
                                                    </#if>
                                                </#if>
                                            </#list>
                                            <#if hasMerch != true>
                                                <@columnData data="${BLANK}" tdclass="mobileHidden mobileMaxColumn"/>
                                            </#if>
                                            
                                            <#list block as extras>
                                                <#if extras[0]?lower_case?matches('child')>
                                                    <#if extras?size == 3 && extras[1]?lower_case?matches("description")>
                                                        <@columnData data="${extras[2]!BLANK}" tdclass="mobileMaxColumn"/>
                                                        <#local hasDesc=true>
                                                    </#if>
                                                <#else>
                                                    <#if extras?size == 2 && extras[0]?lower_case?matches("description")>
                                                        <@columnData data="${extras[1]!BLANK}" tdclass="mobileMaxColumn"/>
                                                        <#local hasDesc=true>
                                                    </#if>
                                                </#if>
                                            </#list>
                                            <#if hasDesc != true>
                                                <@columnData data="${BLANK}" tdclass="mobileMaxColumn"/>
                                            </#if>

                                            <#local columnHTML="" >
                                            
                                            <#list block as extras>
                                                <#if extras[0]?lower_case?matches('child')>
                                                    <#if extras?size == 3 && extras[1]?lower_case?matches("amountspent")>
                                                        <#local columnHTML=columnHTML +'<br><span class="subText" style="font-size: 12px; color: rgb(137, 137, 137);">'+ extras[2] +'</span>'>
                                                    </#if>
                                                    <#if extras?size == 3 && extras[1]?lower_case?matches("amountspentconverted")>
                                                        <#local amountSpent=extras[2]?split(" ")>
                                                        <#local columnHTML=amountSpent[0] + columnHTML>
                                                    </#if>
                                                <#else>
                                                    <#if extras?size == 2 && extras[0]?lower_case?matches("amountspent")>
                                                        <#local columnHTML=columnHTML +'<br><span class="subText" style="font-size: 12px; color: rgb(137, 137, 137);">'+ extras[1] +'</span>'>
                                                    </#if>
                                                    <#if extras?size == 2 && extras[0]?lower_case?matches("amountspentconverted")>
                                                        <#local amountSpent=extras[1]?split(" ")>
                                                        <#local columnHTML=amountSpent[0] + columnHTML>
                                                    </#if>
                                                </#if>
                                            </#list>
                                            <@columnData data=columnHTML tdstyle="text-align: right" tdclass="textRight"/>
                                        </tr>
                                    </#if>
                                </#if>
                            </#list>
                            <#if complianceItem?has_content && isNotParent>
                                <tr class="mobileHidden" style="border-width: 1px 0px 0px; border-right-style: initial; border-bottom-style: initial; border-left-style: initial; border-color: rgb(236, 151, 30); border-image: initial; border-top-style: solid; height: 40px; background-color: rgb(236, 151, 30); font-family: OpenSans, 'Open Sans', Arial; color: rgb(255, 255, 255);">
                                    <td class="complianceWarning mobileHidden" style="padding: 12px 4px 12px 10px" colspan="4">
                                            ${replaceWithConstant('Compliance Warning')}: ${replaceWithConstant(complianceItem[0][1])}
                                        <br>
                                        <span class="subText" style="font-size: 12px;">${replaceWithConstant('Response')}: ${complianceItem[1][1]}</span>
                                    </td>
                                </tr>
                                <tr class="desktopHiddenRow" style="display: none; font-size: 0; mso-hide:all; width:0px;overflow:hidden;max-height:0px;height:0;line-height:0;margin:0 auto;padding-top: 0;padding-bottom: 0;border-width: 1px 0px 0px; border-right-style: initial; border-bottom-style: initial; border-left-style: initial; border-color: rgb(236, 151, 30); border-image: initial; border-top-style: solid; height: 40px; background-color: rgb(236, 151, 30); font-family: OpenSans, 'Open Sans', Arial; color: rgb(255, 255, 255);">
                                    <td class="complianceWarning desktopHiddenData" style="display: none; font-size: 0; mso-hide:all; width:0px;overflow:hidden;max-height:0px;height:0;line-height:0;margin:0 auto;padding-top: 0;padding-bottom: 0;" colspan="3">
                                        ${replaceWithConstant('Compliance Warning')}: ${replaceWithConstant(complianceItem[0][1])}
                                        <br>
                                        <span class="subText" style="font-size: 12px; font-weight: 700;">${replaceWithConstant('Response')}: ${complianceItem[1][1]}</span>
                                    </td>
                                </tr>
                            </#if>
                            <#local index=index+1>
                        </#if>
                    </#list>
                </tbody>
            </table>
            <@summaryTotal listdata=summary extended=false />
        </td>
    </tr>
</#macro>

<#macro summaryTotal listdata extended>
    <#local spanStyle="">
    <#local tdStyle="">
    <#if extended>
        <#local spanStyle="padding-bottom: 13px; padding-left:40px; border-width: 1px 0px 1px; border-bottom-style: dashed; border-bottom-color: rgb(162, 162, 162)">
        <#local tdStyle="border-width: 1px 0px 1px; border-bottom-style: dashed; border-bottom-color: rgb(162, 162, 162)">
    </#if>
    <table class="summaryTable" cellspacing="0" cellpadding="0" style="width: 100%; padding: 12px 5%; font-size: 16px; color: rgb(42, 42, 42);">
        <tbody>
            <#if listdata?size gt 0 >
                <#list listdata as row>
                    <#if row[0]?lower_case?contains('total minus')>
                        <tr class="summaryTable-total border-none" style="color: rgb(0, 0, 0); font-weight: 900;">
                            <td style="width: 99%; border-width: 1px 0px 0px; border-top-style: dashed; border-top-color: rgb(162, 162, 162);"></td>
                            <td align="right" class="textRight" style="width: 1%; border-width: 1px 0px 0px; border-top-style: dashed; border-top-color: rgb(162, 162, 162); padding: 12px 2px 14px 10px; font-weight: 400; text-align: right; vertical-align: bottom; ${spanStyle}">
                                ${replaceWithConstant(row[0])}
                            </td>
                            <td align="right" class="textRight summaryTable-totalAmount" style="white-space: nowrap; width: 1%; border-width: 1px 0px 0px; border-top-style: dashed; border-top-color: rgb(162, 162, 162); padding: 12px 4px 12px 10px; font-weight: 400; text-align: right; font-size: 24px; ${tdStyle}">
                                ${row[1]?split(' ')[0]}
                            </td>
                        </tr>
                    </#if>
                </#list>
                <#if extended>
                    <#list listdata as row>
                        <#if !row[0]?lower_case?contains("total") && !row[0]?lower_case?contains("personal")>
                            <tr class="summaryTable-payable border-none">
                                <td align="right" colspan="2" class="textRight" style="border: 0px; padding: 12px 4px 12px 10px; text-align: right;">${replaceWithConstant(row[0])!BLANK}</td>
                                <td align="right" class="textRight" style="white-space: nowrap; width: 1%; border: 0px; padding: 12px 4px 12px 10px; text-align: right;">${(row[1]?split(' '))[0]}</td>
                            </tr>
                        </#if>
                    </#list>
                </#if>
            </#if>
        </tbody>
    </table>
</#macro>

<#macro midButtons button>
    <#if button?has_content && button?size=2 && button[0]?? && (button[0]?length>1) && button[1]?? && (button[1]?length>1) >
        <tr>
            <td>
                <table align="center" class="actions" bgcolor="#efd" style="width: 100%; background-color: rgb(227, 238, 222); padding: 18px 24px; margin: 48px 0px; text-align: center;">
                        <tr>
                            <td>
                                <table cellspacing="10" align="center">
                                    <tr>
                                        <td style="text-align: center; padding: 7px; width: 180px; border: 1px solid rgb(245, 49, 83); border-radius: 3px; background-color: rgb(255, 255, 255); font-weight: 700; color: rgb(245, 49, 83);">
                                            <a href='mailto:${button[1]}?subject=${replaceWithConstant("Chrome River Expense Approval")} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]
							                    &body=%0D%0A--------------------------------------%0D%0A${getMessageProperty("expense.email.text.approval_return_response_email_text")?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant("Report ID")}: ${expense.reportId} ${replaceWithConstant('Email UID')}: ${expense.emailVersionUID!''}'
                                                class="btn returnBtn" style="text-decoration: none; font-size: 16px; font-weight: 700; text-transform: uppercase; color: rgb(245, 49, 83);">
                                                ${replaceWithConstant("RETURN REPORT")}
                                            </a>&nbsp;
                                        </td>
                                        <td style="text-align: center; padding: 7px; width: 180px; border: 1px solid rgb(84, 195, 84); border-radius: 3px; background-color: rgb(84, 195, 84); font-weight: 700; color: rgb(255, 255, 255)">
                                            <a href='mailto:${button[0]}?subject=${replaceWithConstant("Chrome River Expense Approval")} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]
							                    &body=%0D%0A--------------------------------------%0D%0A${getMessageProperty("expense.email.text.approval_accept_response_email_text")?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant("Report ID")}: ${expense.reportId} ${replaceWithConstant('Email UID')}: ${expense.emailVersionUID!''}' 
                                                class="btn approveBtn" style="text-decoration: none; font-size: 16px; font-weight: 700; text-transform: uppercase; color: rgb(255, 255, 255)">
                                                ${replaceWithConstant("APPROVE REPORT")}
                                            </a>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                </table>
            </td>
        </tr>
    </#if>
</#macro>

<#macro bottomButtons button>
    <#if button?has_content && button?size=2 >
        <td style="background: rgb(227, 238, 222);">
            <table align="center" cellspacing="10" class="actions footer-actions" style="text-align: center; margin: 32px auto; text-align: center;">
                <tr>
                    <td colspan="2" style="font-size: 18px; text-align: center; padding-bottom: 25px;">
                        ${addLabelVar(replaceWithConstant("Approve Expense"),  [expense.firstName])}?
                    </td>
                </tr>
                <tr class="btns">
                <td style="padding: 7px 15px; border: 1px solid rgb(245, 49, 83); border-radius: 3px; background-color: rgb(255, 255, 255); font-weight: 700; color: rgb(245, 49, 83);">
                    <a href='mailto:${button[1]}?subject=${replaceWithConstant("Chrome River Expense Approval")} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]
                        &body=%0D%0A--------------------------------------%0D%0A${getMessageProperty("expense.email.text.approval_return_response_email_text")?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant("Report ID")}: ${expense.reportId} ${replaceWithConstant('Email UID')}: ${expense.emailVersionUID!''}'
                        class="btn returnBtn" style="text-decoration: none; font-size: 18px; font-weight: 700; text-transform: uppercase;color: rgb(245, 49, 83);">
                        ${replaceWithConstant("NO, RETURN REPORT")}
                        </a>&nbsp;
                </td>
                <td style="padding: 7px 15px; border: 1px solid rgb(84, 195, 84); border-radius: 3px; background-color: rgb(84, 195, 84); font-weight: 700; color: rgb(255, 255, 255);">
                    <a href='mailto:${button[0]}?subject=${replaceWithConstant("Chrome River Expense Approval")} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]
                        &body=%0D%0A--------------------------------------%0D%0A${getMessageProperty("expense.email.text.approval_accept_response_email_text")?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant("Report ID")}: ${expense.reportId} ${replaceWithConstant('Email UID')}: ${expense.emailVersionUID!''}' 
                        class="btn approveBtn" style="text-decoration: none; font-size: 18px; font-weight: 700; text-transform: uppercase; color: rgb(255, 255, 255);">
                        ${replaceWithConstant("YES, APPROVE REPORT")}
                    </a>
                </td>
            </tr>
            </table>
        </td>
    </#if>
</#macro>

<#macro writeReceiptLink link reportIdLabel reportId>
    <#if link?? && (link?length>1)>
        <a href="${link}">${replaceWithConstant('View All Reciepts')}</a>
    <#elseif reportId?? && (reportId?length>1)>
        <span>${reportIdLabel}: ${reportId}</span>
	</#if>
</#macro>