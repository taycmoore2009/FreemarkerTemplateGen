<#macro divData style='text-align:left; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;' value="${BLANK}">
	<div style="${style}">${value}</div>
</#macro>

<#function precentToPixelConverter percent width=table_width>
	<#return ((percent*width)/100)?round?string >
</#function>

<#-- additionalAllowedChars parameter specifies which additional characters are allowed in initial keys and will not be removed when property key is generated -->
<#-- in addition to ordinary keys, accepts arrays in form [key, val1,val2,...]
where the first element 'key' is replaced as usual and subsequent "val1", "val2",... elements are used
to replace placeholders like {0},{1}... within the message found by "key"-->
<#function removeSpecialCharactersAndFormKey var prefix additionalAllowedChars=''>
	<#if var?has_content && var?is_enumerable && var[0]?has_content>
    	<#local key = commonPrefix + prefix + var[0]?trim?lower_case?replace('[^a-zA-Z\\d\\s-_'+ additionalAllowedChars +']', '', 'r')?replace(' +','_','r')>
		<#if (var?size>1) >
			<#local label = getMessageProperty(key, var[1..] )>
		<#else>
			<#local label = getMessageProperty(key)>
		</#if>
		<#if label?contains((commonPrefix+prefix))>
			<#return var[0]>
		<#else>
			<#return label>
		</#if>
	<#elseif var?? && (var?trim?length>0)>
		<#local key=commonPrefix + prefix + var?trim?lower_case?replace('[^a-zA-Z\\d\\s-_'+ additionalAllowedChars +']', '', 'r')?replace(' +','_','r')>
		<#local label = getMessageProperty(key)>
		<#if label?contains((commonPrefix+prefix))>
			<#return var>
		<#else>
			<#return label>
		</#if>
	<#else>
		<#return var>
	</#if>
</#function>

<#function replaceWithConstant var, additionalAllowedChars=''>
	<#return removeSpecialCharactersAndFormKey(var, keyPrefix, additionalAllowedChars)>
</#function>

<#function replaceWithConstantForItemType var>
	<#return removeSpecialCharactersAndFormKey(var, itemTypePrefix)>
</#function>

<#function replaceWithConstantForUDA var>
	<#return removeSpecialCharactersAndFormKey(var, udaTypePrefix)>
</#function>

<#function replaceWithConstantForUDF var>
	<#return removeSpecialCharactersAndFormKey(var, udfTypePrefix)>
</#function>

<#function precentToPixelConverter percent width=table_width>
	<#return ((percent*width)/100)?round?string >
</#function>

<#-- allows dots in var , that is doesn't remove dots in var when trying to find corresponding message key-->
<#function replaceWithConstantAllowingDots var>
	<#return removeSpecialCharactersAndFormKey(var, keyPrefix, '.')>
</#function>

<#function getURLWithPrefix urlString>
    <#if urlString?has_content>
        <#if urlString?starts_with('http')>
			<#return urlString>
		<#else>
			<#return 'http://' + urlString>
	</#if>
	<#else>
		<#return ''>
    </#if>
</#function>

<#macro divWithLabelValue label="${BLANK}" value="${BLANK}" style="">
	<div style="${style}">
		${label}: ${value}
	</div>
</#macro>

<#macro columnData tdstyle="" align="" divstyle="" valign="top" data="${HTML_SPACE}" width="${BLANK}">
	<#if (width?length>0)>
		<td valign="${valign}" ${align} style="${tdstyle}" width="${width}">
			<@divData style="${divstyle}" value="${data}" />
		</td>
	<#else>
		<td valign="${valign}" ${align} style="${tdstyle}">
			<@divData style="${divstyle}" value="${data}" />
		</td>
	</#if>
</#macro>

<#macro dataDIVRow tdstyle="" divstyle="" valign="top" data="${HTML_SPACE}">
	<tr> 
		<@columnData tdstyle="${tdstyle}" divstyle="${divstyle}" valign="${valign}" data="${data}"/>
	</tr>
</#macro>

<#macro writeID label="${HTML_SPACE}" value="">
    <tr>
    	<td align='right' valign='top' width='100%'>
    		<@divWithLabelValue label="${label}" value="${value}" style="line-height: 40px; text-align:right; margin-left:5px; margin-right:5px; padding-bottom:2px; padding-top:2px; font-family:tahoma,arial,sans-serif;"/>
    	</td>
    </tr>
</#macro>

<#macro spanData value="${HTML_SPACE}">
	<span>${value}</span>
</#macro>

<#--if valid "value1" overrides "value"
adding 'value1' for cases when it's needed to use newly introduced field in model
and not to break existing logic -->
<#macro writeInfoRowString value="${HTML_SPACE}" value1="${BLANK}">
	<#if value1?? && (value1?length>0)>
		<#assign valueToBeUsed = value1 >
	<#else>
    	<#assign valueToBeUsed=value />
	</#if>
	<#if valueToBeUsed?? && (valueToBeUsed?length>0)>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:left; font-size: 13px;; color:#404040; background:#FFFFFF;">
					<@dataDIVRow />
					<@dataDIVRow tdstyle="${BLANK}" divstyle="font-family:tahoma,arial,sans-serif; max-width:596px;" data="${valueToBeUsed}" />
					<@dataDIVRow />
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeInfoRowPaidExpense value value1="${BLANK}">
	<@writeInfoRowString value=value value1=value1/>
</#macro>

<#macro writeInfoRowList values>
	<#if values?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:left; font-size: 13px;; color:#404040; background:#FFFFFF;">
					<#list values as value>
						<#if value_index = 0>
							<@dataDIVRow />
						</#if>
						<@dataDIVRow divstyle="font-family:tahoma,arial,sans-serif; max-width:596px; -webkit-text-size-adjust:none;" data="${replaceWithConstant(value)}"  />
						<@dataDIVRow />
					</#list>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeHeader value>
	<#if value?has_content && (value?size=2)>
		<tr>
			<td>
				<table cellpadding='0' cellspacing='0' width='100%' style='background:#31B4CB; color:#FFFFFF; font-size:17px; border-radius: 5px 5px 0 0;'>
					<tr>
						<td style='border-bottom: 1pt solid #B4C1C6; padding: 14px 15px 14px 28px;' valign='top'>
							<@divData value="${replaceWithConstant(value[0])}" />
						</td>
						<td style='border-bottom: 1pt solid #B4C1C6; padding: 14px 15px 14px 28px;' valign='top'>
							<@divData style="text-align:right; font-weight:normal; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${value[1]}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeHeaderEmailRow headerNotes>
	<#if headerNotes?has_content>
	<@dataDIVRow />
	<#list headerNotes as headerNote>
		<tr>
			<td valign='top' width='100%'>
				<div style='text-align:left; font-family:tahoma,arial,sans-serif; max-width:596px; margin: 0 24px; width: 552px;'>
					${replaceWithConstant(headerNote[0])} 
					<#if (headerNote[1]?length>0)>
						<u style=' color:#475156; text-decoration:underline; font-family:tahoma,arial,sans-serif; '>${headerNote[1]} </u>
					</#if>
				</div>
			</td>
		</tr>
	</#list>
	</#if>
</#macro>

<#macro writeBottompage>
	<#if hasline>
		<@dataDIVRow tdstyle="border-bottom: 1pt solid #B4C1C6;" />
	<#else>
		<@dataDIVRow tdstyle="${BLANK}" />
	</#if>
</#macro>

<#macro writeButton button>
	<#if button?has_content && button?size=2 && button[0]?? && (button[0]?length>1) && button[1]?? && (button[1]?length>1) >
		<tr>
			<td>
				<table cellpadding='0' cellspacing='0' width='100%' style='background:#FFFFFF;'>
					<tr align='center' valign='middle'>
						<td width="${precentToPixelConverter(25)}" align='center' valign='middle'>
							<br/>
						</td>
						<td width="${precentToPixelConverter(20)}" style='padding-top:5px; padding-bottom:5px; background:#2EB075; border: 2pt solid #138D56; min-width:100px; max-width:115px;' align='center' valign='middle'>
							<a style="font-family:tahoma,arial,sans-serif; font-size:11pt; font-weight:bold; color:white; background:#2EB075; text-decoration:none;" href='mailto:${button[0]}?subject=${replaceWithConstant('Chrome River Expense Approval')} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]
							&body=%0D%0A--------------------------------------%0D%0A${getMessageProperty('expense.email.text.approval_accept_response_email_text')?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant('Report ID')}: ${expense.reportId}'>${replaceWithConstant('ACCEPT')}</a>
						</td>
						<td width="${precentToPixelConverter(10)}" align='center' valign='middle'>
							<br/>
						</td>
						<td width="${precentToPixelConverter(20)}" style='padding-top:5px; padding-bottom:5px; background:#DB5947; border: 2pt solid #C00000; min-width:100px; max-width:115px;' align='center' valign='middle'>
							<a style="font-family:tahoma,arial,sans-serif; font-size:11pt; font-weight:bold; color:white; background:#DB5947; text-decoration:none;" href='mailto:${button[1]}?subject=${replaceWithConstant('Chrome River Expense Approval')} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]
							&body=%0D%0A--------------------------------------%0D%0A${getMessageProperty('expense.email.text.approval_return_response_email_text')?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant('Report ID')}: ${expense.reportId}'>${replaceWithConstant('RETURN')}</a>
						</td>
						<td width="${precentToPixelConverter(25)}" align='center' valign='middle'>
							<br/>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeButton101 button101>
	<#if button101?has_content>
		<#-- writeBottompage -->
		<@writeBottompage />
		<#-- writeButton -->
		<@writeButton button=button101 />
		<#if expense.inforowswhichcontainsemails?has_content>
			<#assign hasline=true />
		<#else>
			<#assign hasline=false />
		</#if>
		<#-- writeBottompage -->
		<@writeBottompage />
		<#assign hasline=false />
	</#if>
</#macro>

<#macro writeInforowswhichcontainsemails inforowswhichcontainsemails>
	<#if inforowswhichcontainsemails?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; color: #9FA4A6; font-size: 13px;text-align: center;">
					<#if header>
						<@dataDIVRow />
					</#if>
					<tr>
						<td valign="top">
							<div style="font-family:tahoma,arial,sans-serif; max-width:596px; -webkit-text-size-adjust:none; margin-left:5px; margin-right:5px;">
								<#list inforowswhichcontainsemails as inforowswhichcontainsemail>
									<#if inforowswhichcontainsemail?? && (inforowswhichcontainsemail?size>1)>
										<#if (inforowswhichcontainsemail[0]?length>1) && inforowswhichcontainsemail[0]?index_of("_")=1>
											<@spanData /><@spanData /><@spanData />
											<@spanData /><@spanData /><@spanData />
										</#if>
										<#if (inforowswhichcontainsemail?size=3)>
											<@spanData value="${getMessageProperty(commonPrefix + keyPrefix + inforowswhichcontainsemail[2])}"/>
										<#else>
											<@spanData value="${inforowswhichcontainsemail[0]}"/>
										</#if>
										<#if (inforowswhichcontainsemail[1]?length>1)>
											<u style="text-decoration:underline; font-family:tahoma,arial,sans-serif; -webkit-text-size-adjust:none;">
												${inforowswhichcontainsemail[1]}
											</u>
										<#elseif (inforowswhichcontainsemail[1]?length=1)>
											<br/>
										<#else>
											<br/><br/>
										</#if>
									</#if>
								</#list>
							</div>
						</td>
					</tr>
					<#if header>
						<@dataDIVRow />
					</#if>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeExpenseRow expenserowdata>
	<#if (expenserowdata?has_content)>
		<#assign width_td = 25 >
		<#assign i = 0 >
		<tr>
	    	<td>
	            <table cellpadding="0" cellspacing="0" align="center" width="100%" style="line-height: 25px; margin: 0 24px; width: 552px; font-size: 13px;; font-weight:normal; color:#404040; background:#FFFFFF;">
	            	<#list expenserowdata as expenserow>
	            		<#if (expenserow??) && (expenserow?size > 1)>
							<#if (expenserow[0]?upper_case?matches(replaceWithConstant('Pre-Approval Request For')?upper_case))>
            					<#assign width_td = 35 >
            				</#if>
            				<#if expenserow_index = 0>
            					<tr>
            						<td id="tdcol" style="border-top: 1pt solid #B4C1C6;" valign="top" width="${precentToPixelConverter(width_td)}">
            							<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:${precentToPixelConverter(width_td)}px;" value="${replaceWithConstant(expenserow[0])}" />
            						</td>
            						<td style="border-top: 1pt solid #B4C1C6;" valign="top" width="${precentToPixelConverter(100-width_td)}">
            							<@divData style="font-weight: bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:${precentToPixelConverter((100-width_td))}px;" value="${expenserow[1]}" />
            						</td>
            					</tr>
        					<#else>
        						<tr>
            						<td class="tdcol" style="border-top: 0pt solid #B4C1C6;" valign="top" width="${precentToPixelConverter(width_td)}">
            							<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:${precentToPixelConverter(width_td)}px;" value="${replaceWithConstant(expenserow[0])}" />
            						</td>
            						<td  valign="top" width="${precentToPixelConverter(100-width_td)}">
            							<@divData style="font-weight: bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:${precentToPixelConverter(100-width_td)}px;" value="${expenserow[1]}" />
            						</td>
            					</tr>
            				</#if>
	            		</#if>
	            	</#list>
	            	<tr>
            			<td style="border-top: 1pt solid #B4C1C6;" valign="top" colspan="2">
            				<div>${HTML_SPACE}</div>
            			</td>
            		</tr>
	            </table>
	        </td>
		</tr>            	
	</#if>
</#macro>

<#macro writeexpensereportnotes w1 w2 w3 name listdata>
	<#if (listdata?has_content)>
		<#assign styles_for_border = "${BLANK}" >
		<tr>
	    	<td>
    	        <table cellpadding="0" cellspacing="0" width="100%" style="line-height: 30px; margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
        			<tr>
        				<td colspan="3">
        					<@divData style="color:#475156; font-size:18px; font-weight:bold; text-align:left; line-height: 27px; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${name}" />
        				<td>
        			</tr>
        			<#list listdata as row>
						<#assign styles_for_border = "border-top: 1pt solid #B4C1C6;" >
        				<#if (row??) && (row?size > 1)>
       						<tr>
        						<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(w1)}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:75px;" data="${row[0]}"/>
        						<td valign="top" style="${styles_for_border}" width="${precentToPixelConverter(w2)}">
        							<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:75px;" value="${row[1]}" />
        						</td>
        						<td valign="top" style="${styles_for_border}" width="${precentToPixelConverter(w3)}">
        							<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:75px;" value="${row[2]}" />
        						</td>
        					</tr>
        				</#if>
        			</#list>
	        		<tr>
	        			<td style=" border-top: 1pt solid #B4C1C6;" valign="top" colspan="3">
	        				<div>${HTML_SPACE}</div>
	        			</td>
	        		</tr>
	            </table>
	        </td>
		</tr>            	
	</#if>
</#macro>

<#macro writeunapproveditems name column_names widths text_aligns listdata>

    <#if !(column_names?has_content) >
        <#assign sub_names = [replaceWithConstant('Owner'), replaceWithConstant('Report'), replaceWithConstant('Created'), replaceWithConstant('Amount')]>
    <#else>
        <#assign sub_names = [] >
        <#list column_names as current_column>

            <#if current_column?? && current_column?has_content>
                <#assign sub_names = sub_names + [replaceWithConstant(current_column)] >
            </#if>
        </#list>
    </#if>
	<#if (listdata?has_content)>
		<#assign styles_for_border = "" >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<tbody>
						<tr>
							<td colspan="${sub_names?size?string}" >
								<@divData style="color:#475156; font-size:18px; line-height: 27px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left;" value="${name}" />
							</td>
						</tr>
						<tr>
							<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[0])}" 
								divstyle="text-align:${text_aligns[0]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[0]}"/>
							<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[1])}" 
								divstyle="text-align:${text_aligns[1]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[1]}"/>
							<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[2])}" 
								divstyle="text-align:${text_aligns[2]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[2]}"/>
							<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[3])}" 
								divstyle="text-align:${text_aligns[3]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[3]}"/>
							<#if (sub_names?size = 5)>
								<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[4])}" 
								divstyle="text-align:${text_aligns[4]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[4]}"/>
							</#if>		
						</tr>
						<#list listdata as row>	
							<#assign styles_for_border = "border-top: 1pt solid #B4C1C6;" >
            				<#if (row??) && (row?size > 3)>
            					<tr>
            						<@columnData tdstyle="${styles_for_border}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[0]} max-width:${precentToPixelConverter(widths[0])}px;" data="${row[0]}"/>
									<@columnData tdstyle="${styles_for_border}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[1]} max-width:${precentToPixelConverter(widths[1])}px;" data="${row[1]}"/>
									<@columnData tdstyle="${styles_for_border}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[2]} max-width:${precentToPixelConverter(widths[2])}px;" data="${row[2]}"/>
									<@columnData tdstyle="${styles_for_border}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[3]} max-width:${precentToPixelConverter(widths[3])}px;" data="${row[3]}"/>
									<#if sub_names?size = 5>
										<@columnData tdstyle="${styles_for_border}" 
											divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[4]} max-width:${precentToPixelConverter(widths[4])}px;" data="${row[4]}"/>
									</#if>	
            					</tr>
            				</#if>
            			</#list>
            			<tr>
            				<td style ="border-top: 1pt solid #B4C1C6;" colspan=${sub_names?size?string} >
            					<div>${HTML_SPACE}</div>
            				</td>
            			</tr>
            		</tbody>
            	</table>	
            </td>
		</tr>
	</#if>
</#macro>

<#macro writeUnsubmittedreports unsubmittedreportsdata sub_names>
	<#assign widths = [25, 35, 20, 20]>
	<#assign aligns = ["left;", "left;", "center;", "right;"]>
	<@writeunapproveditems name="${replaceWithConstant('Unsubmitted Reports')}" column_names=sub_names widths=widths text_aligns=aligns listdata=unsubmittedreportsdata/>
</#macro>

<#macro writeUnapproveditemsreminder unapproveditemsreminderdata>
	<#if unapproveditemsreminderdata?has_content>
		<#assign uir_mas_size = unapproveditemsreminderdata[0]?size>
		<#if uir_mas_size = 4>
			<#assign sub_names = [replaceWithConstant('Owner'), replaceWithConstant('Report'), replaceWithConstant('Created'), replaceWithConstant('Amount')]>
			<#assign widths = [25, 35, 20, 20]>
			<#assign aligns = ["left;", "left;", "center;", "right;"]>
			<@writeunapproveditems name="${replaceWithConstant('Unapproved Expense Items')}" column_names=sub_names widths=widths text_aligns=aligns listdata=unapproveditemsreminderdata/>
		</#if>
		<#if uir_mas_size = 5>
			<#assign sub_names = [replaceWithConstant('Owner'), replaceWithConstant('Report'), replaceWithConstant('Report ID'), replaceWithConstant('Created'), replaceWithConstant('Amount')]>
			<#assign widths = [20, 20, 20, 20, 20]>
			<#assign aligns = ["left;", "left;", "left;", "center;", "right;"]>
			<@writeunapproveditems name="${replaceWithConstant('Unapproved Expense Items')}" column_names=sub_names widths=widths text_aligns=aligns listdata=unapproveditemsreminderdata/>
		</#if>
	</#if>
</#macro>

<#macro writePaidExpenses name sub_names widths text_aligns listdata bFirst>
	<#if listdata?has_content>
		<#assign styles_for_border="${BLANK}" >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<#if bFirst>
						<tr>
							<td colspan="${sub_names?size?string}">
								<@divData style="color:#475156; font-size:18px; line-height: 24px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left;" value="${replaceWithConstant('Paid Expenses')}" />
							</td>
						</tr>
					</#if>
					<tr>
						<td colspan="${sub_names?size?string}">
							<@divData style="font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left;" value="${name}" />
						</td>
					</tr>
					<tr>
						<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6" width="${precentToPixelConverter(widths[0])}" 
							divstyle="text-align:${text_aligns[0]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[0]}"/>
						<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[1])}" 
							divstyle="text-align:${text_aligns[1]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[1]}"/>
						<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[2])}" 
							divstyle="text-align:${text_aligns[2]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[2]}"/>
						<#if (sub_names?size > 3)>
							<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[3])}" 
								divstyle="text-align:${text_aligns[3]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[3]}"/>
						</#if>
						<#if (sub_names?size = 5)>
							<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[4])}" 
								divstyle="text-align:${text_aligns[4]} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${sub_names[4]}"/>
						</#if>
					</tr>
					<#list listdata as row>
						<#assign styles_for_border = "border-top: 1pt solid #B4C1C6;" >
        				<#if (row??) && (row?size>2)>
        					<tr>
        						<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[0]} max-width:${precentToPixelConverter(widths[0])}px;" data="${row[0]}"/>
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[1]} max-width:${precentToPixelConverter(widths[1])}px;" data="${row[1]}"/>
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[2]} max-width:${precentToPixelConverter(widths[2])}px;" data="${row[2]}"/>
								<#if (sub_names?size > 3)>
									<@columnData tdstyle="${styles_for_border}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[3]} max-width:${precentToPixelConverter(widths[3])}px;" data="${row[3]}"/>
								</#if>
								<#if (sub_names?size = 5)>
									<@columnData tdstyle="${styles_for_border}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:${text_aligns[4]} max-width:${precentToPixelConverter(widths[4])}px;" data="${row[4]}"/>
								</#if>
        					</tr>
        				</#if>
					</#list>
					<tr>
        				<td style ="border-top: 1pt solid #B4C1C6;" colspan="${sub_names?size?string}">
        					<div>${HTML_SPACE}</div>
        				</td>
        			</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writePaidExpenses1 paymentDateToPaidExpense isSuppressEFTCheckNumber>
	<#assign bFirst = true>
	<#if paymentDateToPaidExpense?has_content>
		<#list paymentDateToPaidExpense.keySet() as key>
		<#if isSuppressEFTCheckNumber && paymentDateToPaidExpense.get(key)?? && paymentDateToPaidExpense.get(key).get(0)?size == 3>
			<#assign sub_names = [replaceWithConstant('Report ID'), replaceWithConstant('Report Name'), replaceWithConstant('Approved Amount')]>
			<#assign widths = [20, 50, 30]>
			<#assign aligns = ["left;", "left;", "right;"]>
		<#elseif isSuppressEFTCheckNumber && paymentDateToPaidExpense.get(key)?? && paymentDateToPaidExpense.get(key).get(0)?size == 4>
			<#assign sub_names = [replaceWithConstant('Report ID'), replaceWithConstant('Report Name'),  replaceWithConstant('Payment Type'), replaceWithConstant('Approved Amount')]>
			<#assign widths = [18, 38, 20, 24]>
			<#assign aligns = ["left;", "left;", "center;", "right;"]>
		<#elseif !isSuppressEFTCheckNumber && paymentDateToPaidExpense.get(key)?? && paymentDateToPaidExpense.get(key).get(0)?size == 4>
			<#assign sub_names = [replaceWithConstant('Report ID'), replaceWithConstant('Report Name'),  replaceWithConstant('Check/EFTnum'), replaceWithConstant('Approved Amount')]>
			<#assign widths = [18, 42, 16, 24]>
			<#assign aligns = ["left;", "left;", "center;", "right;"]>
		<#elseif paymentDateToPaidExpense.get(key)?? && paymentDateToPaidExpense.get(key).get(0)?size == 5>
			<#assign sub_names = [replaceWithConstant('Report ID'), replaceWithConstant('Report Name'),  replaceWithConstant('Payment Type'), replaceWithConstant('Check/EFTnum'), replaceWithConstant('Approved Amount')]>
			<#assign widths = [16, 27, 18, 16, 23]>
			<#assign aligns = ["left;", "left;", "left;", "right;", "right;"]>
		</#if>
		    <@writePaidExpenses name="${replaceWithConstant('Date Payment Initiated')+': '+key}" sub_names=sub_names widths=widths text_aligns=aligns listdata=paymentDateToPaidExpense.get(key) bFirst=bFirst />
		    <#assign bFirst = false>
		</#list>
	</#if>
</#macro>

<#macro writePreapprovalunapproveditems preapprovalunapproveditems>
	<#if preapprovalunapproveditems?has_content>
		<#assign styles_for_border="${BLANK}">
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<@columnData tdstyle="color: #999;  border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(30)}" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Owner')}"/>
						<@columnData tdstyle="color: #999;  border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(35)}" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Report Number')}"/>
						<@columnData tdstyle="color: #999;  border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(15)}" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Submit')}"/>
						<@columnData tdstyle="color: #999;  border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(25)}" 
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Amount')}"/>
					</tr>
					<#list preapprovalunapproveditems as row>
						<#assign styles_for_border = "border-top: 1pt solid #B4C1C6;" >
        				<#if (row??) && (row?size > 3)>
        					<tr>
        						<@columnData tdstyle="background:${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[0]}"/>
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[1]}"/>
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:center;" data="${row[2]}"/>
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; min-width:90px;" data="${row[3]}"/>
        					</tr>
        				</#if>
					</#list>
					<tr>
        				<td style ="border-top: 1pt solid #B4C1C6;" colspan="4" >
        					<div>${HTML_SPACE}</div>
        				</td>
        			</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeUnusedfirmpaiditemsinfo firmpaiditemsinfo>
	<#if firmpaiditemsinfo?has_content && firmpaiditemsinfo?size=2 && firmpaiditemsinfo[0]?? && firmpaiditemsinfo[1]??>
		<tr>
			<td>
				<table cellpadding=0 cellspacing=0 width=100% style="margin: 0 24px; width: 552px; text-align:left; font-size: 13px;; color:#404040; background:#FFFFFF;">
					<@dataDIVRow />	
					<@dataDIVRow divstyle="color:#31B4CB; font-size:21px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left; max-width:596px;" data="${replaceWithConstant(firmpaiditemsinfo[0])}" />
					<@dataDIVRow divstyle="line-height: 24px; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;" data="${replaceWithConstant(firmpaiditemsinfo[1])}" />
					<@dataDIVRow />			
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeunsubmittedreportitems name column_names widths listdata>

	<#if !(column_names?has_content) >
		<#assign sub_names = [replaceWithConstant('Owner'), replaceWithConstant('Report'), replaceWithConstant('Description'), replaceWithConstant('Amount')]>
	<#else>
		<#assign sub_names = [] >
		<#list column_names as current_column>

			<#if current_column?? && current_column?has_content>
				<#assign sub_names = sub_names + [replaceWithConstant(current_column)] >
			</#if>
		</#list>
	</#if>
	<#if listdata?has_content >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size:13px; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<td colspan="${sub_names?size}">
							<@divData style="line-height: 27px; color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left;" value="${name}" />
						</td>
					</tr>
					<tr>
						<@columnData tdstyle="color: #999999; border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[0])}"
							divstyle="font-size: 12px; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold; max-width:${precentToPixelConverter(widths[0])}px;" data="${sub_names[0]}"/>
						<@columnData tdstyle="color: #999999; border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[1])}" 
							divstyle="font-size: 12px; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold; max-width:${precentToPixelConverter(widths[1])}px;" data="${sub_names[1]}"/>
						<@columnData tdstyle="color: #999999; border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[2])}" 
							divstyle="font-size: 12px; text-align:center; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold; max-width:${precentToPixelConverter(widths[2])}px;" data="${sub_names[2]}"/>
						<@columnData tdstyle="color: #999999; border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[3])}" 
							divstyle="font-size: 12px; text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold; max-width:${precentToPixelConverter(widths[3])}px;" data="${sub_names[3]}"/>
						<#if (sub_names?size = 5)>
							<@columnData tdstyle="color: #999999; border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" width="${precentToPixelConverter(widths[4])}" 
								divstyle="font-size: 12px; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold; max-width:${precentToPixelConverter(widths[4])}px;" data="${sub_names[4]}"/>
						</#if>
					</tr>
					<#list listdata as row>
						<#if (row??) && (row?size > 3)>
							<tr>
								<@columnData tdstyle="padding: 5px 0;" width="${precentToPixelConverter(widths[0])}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(widths[0])}px;" data="${row[0]}"/>
								<@columnData tdstyle="padding: 5px 0;" width="${precentToPixelConverter(widths[1])}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(widths[1])}px;" data="${row[1]}"/>
								<@columnData tdstyle="padding: 5px 0;" width="${precentToPixelConverter(widths[2])}" 
									divstyle="text-align:center; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(widths[2])}px;" data="${row[2]}"/>
								<@columnData tdstyle="padding: 5px 0;" width="${precentToPixelConverter(widths[3])}" 
									divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(widths[3])}px;" data="${row[3]}"/>
								<#if (sub_names?size = 5)>
									<@columnData tdstyle="padding: 5px 0;" width="${precentToPixelConverter(widths[4])}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(widths[4])}px;" data="${row[4]}"/>
								</#if>
							</tr>
						</#if>
					</#list>
					<tr>
        				<td style ="border-top: 1pt solid #B4C1C6;" colspan="${sub_names?size}" >
        					<div>${HTML_SPACE}</div>
        				</td>
        			</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeUnusedfirmpaidreminderdays30 unusedfirmpaidreminderdays30 sub_names_param>
	<#assign widths = [20, 30, 30, 20]>
	<@writeunsubmittedreportitems name="${replaceWithConstant('0-30 Days')}" column_names=sub_names_param widths=widths listdata=unusedfirmpaidreminderdays30 />
</#macro>

<#macro writeUnusedfirmpaidreminderdays31_60 unusedfirmpaidreminderdays31_60 sub_names_param>
	<#assign widths = [20, 30, 30, 20]>
	<@writeunsubmittedreportitems name="${replaceWithConstant('31-60 Days')}" column_names=sub_names_param widths=widths listdata=unusedfirmpaidreminderdays31_60 />
</#macro>

<#macro writeUnusedfirmpaidreminderdays61_90 unusedfirmpaidreminderdays61_90 sub_names_param>
	<#assign widths = [20, 30, 30, 20]>
	<@writeunsubmittedreportitems name="${replaceWithConstant('61-90 Days')}" column_names=sub_names_param widths=widths listdata=unusedfirmpaidreminderdays61_90 />
</#macro>

<#macro writeUnusedfirmpaidreminderdays90Plus unusedfirmpaidreminderdays90Plus sub_names_param>
	<#assign widths = [20, 30, 30, 20]>
	<@writeunsubmittedreportitems name="${replaceWithConstant('91+ Days')}" column_names=sub_names_param widths=widths listdata=unusedfirmpaidreminderdays90Plus />
</#macro>

<#macro writePAButton listdata>
	<#if listdata?has_content && listdata?size=2 && listdata[0]?? && listdata[1]??>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="background:#FFFFFF;">
					<tr align="center" valign="middle">
						<td width="${precentToPixelConverter(25)}" align="center" valign="middle">
							<br/>
						</td>
						<td width="${precentToPixelConverter(20)}" style="padding-top:5px; padding-bottom:5px; background:#2EB075; border: 2pt solid #138D56; min-width:100px; max-width:115px;" align="center" valign="middle">
							<a style="font-family:tahoma,arial,sans-serif; font-size:11pt; font-weight:bold; color:white; background:#2EB075; text-decoration:none;" href="mailto:${listdata[0]}?subject=${replaceWithConstant('Chrome River Pre-Approval Request')} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]+
                                 &body=%0D%0A--------------------------------------%0D%0A${getMessageProperty('preapproval.email.text.pre-approval_accept_response_email_text')?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant('Pre-Approval ID')}:${expense.reportId}">${replaceWithConstant('ACCEPT')}</a>
						</td>
						<td width="${precentToPixelConverter(10)}" align="center" valign="middle">
							<br/>
						</td>
						<td width="${precentToPixelConverter(20)}" style="padding-top:5px; padding-bottom:5px; background:#DB5947; border: 2pt solid #C00000; min-width:100px; max-width:115px;" align="center" valign="middle">
							<a style="font-family:tahoma,arial,sans-serif; font-size:11pt; font-weight:bold; color:white; background:#DB5947; text-decoration:none;" href="mailto:${listdata[1]}?subject=${replaceWithConstant('Chrome River Pre-Approval Request')} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]+
                                 &body=%0D%0A--------------------------------------%0D%0A${getMessageProperty('preapproval.email.text.pre-approval_accept_response_email_text')?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant('Pre-Approval ID')}:${expense.reportId}">${replaceWithConstant('RETURN')}</a>
						</td>
						<td width="${precentToPixelConverter(25)}" align="center" valign="middle">
							<br/>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeUnapprovedInvoicesReminder listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<td colspan="5">
							<@divData style="color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left;" value="${replaceWithConstant('Assigned to:')}${listdata[0][0]}" />
						</td>
					</tr>
					<tr>
						<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Vendor')}" />
						<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Invoice Number')}" />
						<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Invoice Date')}" />
						<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Amount')}" />
						<@columnData tdstyle="color: #999; border-top: 1pt solid #B4C1C6;" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; font-weight:bold;" data="${replaceWithConstant('Assigned')}" />
					</tr>
					<#list listdata as row>
						<#assign styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#if row?? && (row?size>5)>
							<tr>
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[0]}" />
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[2]}" />
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[3]}" />
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[4]}" />
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[5]}" />
							</tr>
						</#if>
					</#list>
					<tr>
						<td colspan="5" style="border-top: 1pt solid #B4C1C6;">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeSummaries name listdata>
	<#if listdata?has_content>
		<#assign buf_array=(listdata[0])[1]?split(" ") >
		<#assign currency="" >
		<#if buf_array?? && (buf_array?size>1) >
			<#assign currency=buf_array[1] >
		</#if>
		<#if (currency?length>0)>
			<#local label="${replaceWithConstant('Amount')} (${currency})">
		<#else>
			<#local label="">
		</#if>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px; color:#404040; text-align:right; background:#FFFFFF;">
					<#assign firstItem = listdata[0]!DUMMY_ARRAY>
					<#if firstItem?size=3>
						<tr>
							<@columnData width="${precentToPixelConverter(25)}"
								divstyle="color:#475156; font-size:18px; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${name}" />
							<@columnData width="${precentToPixelConverter(20)}" 
								divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" data="${label}" />
							<td width="${precentToPixelConverter(55)}" valign='top'>
								<br/>
							</td>
						</tr>
					<#else>
						<tr>
							<@columnData width="${precentToPixelConverter(50)}" align="align='left'"
								divstyle="color:#475156; font-size:18px; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${name}" />
							<@columnData width="${precentToPixelConverter(50)}" 
								divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${label}" />
						</tr>
					</#if>
					<#list listdata as row>
						<#assign styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#if row?? && (row?size>1)>
							<tr>
								<#if row?size=3>
									<@columnData align="align='left'" tdstyle="text-align: left;${styles_for_border};" width="${precentToPixelConverter(25)}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${replaceWithConstant(row[0])}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${(row[1]?split(' '))[0]}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(55)}" 
										divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:328px;" data="${row[2]}" />
								<#else>
									<@columnData align="align='left'" tdstyle="text-align: left;${styles_for_border};" width="${precentToPixelConverter(50)}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${replaceWithConstant(row[0])}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(50)}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${(row[1]?split(' '))[0]}" />
								</#if>
							</tr>
						</#if>
					</#list>
					<tr>
						<#if firstItem?size=3>
							<td colspan="3" style="border-top: 1pt solid #B4C1C6;">
						<#else>
							<td colspan="2" style="border-top: 1pt solid #B4C1C6;">
						</#if>
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeFinancialsummary listdata>
	<@writeSummaries name="${replaceWithConstant('Financial Summary')}" listdata=listdata />
</#macro>

<#macro writeExpensetransactions listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<td colspan="4">
							<@divData style="color:#475156; font-size:18px; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${replaceWithConstant('Expense Transactions')}" />
						</td>
					</tr>
					<#list listdata as row>
						<#assign styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#if row?? && (row?size>3)>
							<tr>
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[0]}" />
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[1]}" />
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[2]}" />
								<@columnData tdstyle="${styles_for_border}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; min-width:90px;" data="${row[3]}" />
							</tr>
						</#if>
					</#list>
					<tr>
						<td colspan="4" style="border-top: 1pt solid #B4C1C6;">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeExpensepurpose name listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:left; font-size: 13px;; color:#404040; background:#FFFFFF;">
					<@dataDIVRow tdstyle="" divstyle="color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${name}"  />
					<#list listdata as row>
						<#if row_index = 0>
							<#assign styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#else>
							<#assign styles_for_border= "${BLANK}">
						</#if>
						<@dataDIVRow tdstyle="${styles_for_border}" divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;" data="${row}"  />
					</#list>
					<@dataDIVRow tdstyle="border-top: 1pt solid #B4C1C6;" divstyle="" data="${HTML_SPACE}"  />
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeAddtlnotes listdata>
	<@writeExpensepurpose name="${replaceWithConstant('Addtl Notes')}" listdata=listdata />
</#macro>

<#macro writeUdadatadetail listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;" 
							divstyle="color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left;" data="${replaceWithConstant('Guest Data')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Internal Guests')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('External Guests')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;" 
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Guests')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;" 
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Total Cost')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;" 
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Per Guest')}" />
					</tr>
					<#list listdata as row>
						<#if row?? && (row?size>5)>
							<tr>
								<@columnData tdstyle="background:" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstantForUDA(row[0])}" />
								<@columnData tdstyle="" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[1]}" />
								<@columnData tdstyle="" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[2]}" />
								<@columnData tdstyle="" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right;" data="${row[3]}" />
								<@columnData tdstyle="" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right;" data="${row[4]}" />
								<@columnData tdstyle="" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right;" data="${row[5]}" />
							</tr>
						</#if>
					</#list>
					<tr>
						<td colspan="6" style="border-top: 1pt solid #B4C1C6;">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeBusinesspurpose104 listdata>
	<@writeExpensepurpose name="${replaceWithConstant('Business Purpose')}" listdata=listdata />
</#macro>

<#macro writeExpenseaccountsummary name listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:left; font-size: 13px;; color:#404040; background:#FFFFFF;">
					<tr>
						<#list listdata as row>
							<#if row??>
								<#if (row?size>4)>
									<#local columnamount="4">
									<#local columns="5">
								<#else>
									<#local columnamount="3">
									<#local columns="4">
								</#if>
							</#if>
						</#list>
						<td colspan="${columnamount}">
							<@divData style="color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${name}" />
						</td>
						<td colspan="1">
							<@divData style="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${replaceWithConstant('Amount')} (${expense.currency})" />
						</td>
					</tr>
					<#list listdata as row>
						<#if row??>
							<#if row_index = 0>
								<#assign styles_for_border= "border-top: 1pt solid #B4C1C6;">
							<#else>
								<#assign styles_for_border= "${BLANK}">
							</#if>
							<#if row?size=1>
								<tr>
									<td colspan="1" style="${styles_for_border}">
										<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;" value="${row[0]}" />
									</td>
								</tr>
							<#elseif row?size=4>
								<tr>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary4items[0])}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[0]}"/>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary4items[1])}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[1]}"/>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary4items[2])}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[2]}"/>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary4items[3])}" 
										divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${row[3]}"/>
								</tr>
							<#elseif row?size=5>
								<tr>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary5items[0])}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:70px;" data="${row[0]}"/>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary5items[1])}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[1]}"/>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary5items[2])}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[2]}"/>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary5items[3])}" 
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[3]}"/>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary5items[4])}" 
										divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${row[4]}"/>
								</tr>
							</#if>
						</#if>
					</#list>
					<tr>
						<td style="border-top: 1pt solid #B4C1C6;" colspan="${columns}">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeAccountsummary84 listdata>
	<#assign accountsummary4items = [25, 27, 28, 20]>
	<@writeExpenseaccountsummary name="${replaceWithConstant('Account Summary')}" listdata=listdata />
	<#assign accountsummary4items = [15, 30, 35, 20]>
</#macro>

<#macro writeExpensereportnotes w1 w2 w3 name listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; line-height: 30px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<td colspan="3">
							<@divData style="color:#475156; font-size:18px; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${name}" />
						</td>
					</tr>
					<#list listdata as row>
						<#if row_index = 0>
							<#assign styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#else>
							<#assign styles_for_border= "${BLANK}">
						</#if>
						<#if row?? && (row?size>1)>
							<tr>
								<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(w1)}" divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:75px;" data="${row[0]}" />
								<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(w2)}" divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[1]}" />
								<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(w3)}" divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[2]?replace('\n','<br>')?replace('\r','<br>')}" />
							</tr>
						</#if>
					</#list>
					<td colspan="3" style="border-top: 1pt solid #B4C1C6;">
						<@divData style="" value="${HTML_SPACE}" />
					</td>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeGrandtotal data grandTotalLabel='Grand Total' grandTotalAlignment='left'>
	<#if data?? && (data?length>0)>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:${grandTotalAlignment};font-size: 13px;; color:#404040; background:#FFFFFF;">
					<tr>
						<td>
							<span style="color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left">${replaceWithConstant(grandTotalLabel)}</span>
							<span style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left">${data}</span>
						</td>
					</tr>
					<@dataDIVRow />
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeTotalReimbursements data totalReimbursementsLabel='Total Reimbursements' totalReimbursementsAlignment='left'>
	<#if data?? && (data?length>0)>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:${totalReimbursementsAlignment};font-size: 13px;; color:#404040; background:#FFFFFF;">
					<tr>
						<td>
							<span style="color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left">${replaceWithConstant(totalReimbursementsLabel)}</span>
							<span style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left">${data}</span>
						</td>
					</tr>
					<@dataDIVRow />
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeTotalCompanyPaid data totalCompanyPaidLabel='Total Company Paid' totalCompanyPaidAlignment='left'>
	<#if data?? && (data?length>0)>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:${totalCompanyPaidAlignment};font-size: 13px;; color:#404040; background:#FFFFFF;">
					<tr>
						<td>
							<span style="color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left">${replaceWithConstant(totalCompanyPaidLabel)}</span>
							<span style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left">${data}</span>
						</td>
					</tr>
					<@dataDIVRow />
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeExpenseitems listdata>
	<#if listdata?has_content>
		<#local listdataSize=listdata?size>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<td colspan="4">
							<@divData style="color:#475156; font-size:18px; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${replaceWithConstant('Expense Items')}" />
						</td>
					</tr>
					<#list listdata as row>
						<#if row_index = 0>
							<#assign styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#else>
							<#assign styles_for_border= "${BLANK}">
						</#if>
						<#if row?? && (row?size>3)>
							<tr>
								<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(20)}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[0]}"/>
								<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(30)}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[1]}"/>
								<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(35)}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${row[2]}"/>
								<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(15)}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; min-width:90px;" data="${row[3]}"/>
							</tr>
							<#if (row[0]?length<1)>
								<#if row_index ! listdataSize>
									<#local styles_for_border2= "border-top: 1pt solid #B4C1C6;">
								<#else>
									<#local styles_for_border2= "${BLANK}">
								</#if>
								<tr>
									<td style="${styles_for_border2}" colspan="4">
										<@divData style="" value="${HTML_SPACE}" />
									</td>
								</tr>
							</#if>
						</#if>
					</#list>
					<tr>
						<td colspan="4" style="border-top: 1pt solid #B4C1C6;">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeUnusedtransactions unusedtransactions>
	<#assign sub_names = [replaceWithConstant('Owner'),replaceWithConstant('Report'), replaceWithConstant('Description'), replaceWithConstant('Amount')]>
	<#assign widths = [25, 25, 30, 20]>
	<#assign aligns = ["left;", "left;", "left;", "right;"]>
	<@writeunapproveditems name="${replaceWithConstant('Unsubmitted Reports')}" column_names=sub_names widths=widths text_aligns=aligns listdata=unusedtransactions />
</#macro>

<#macro writeTotal total>
	<#if (total??) && (total?size = 2) && (total[0]??) && (total[1]??)>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size:18px; color:#404040; text-align:left; background:#FFFFFF;">
					<tbody>
						<tr>
							<td>
								<div style="color:#475156; font-size:12px; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
									${replaceWithConstant(total[0])}
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div style="color: #404040; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
									${total[1]}
								</div>
							</td>
						</tr>
						<tr>
            				<td>
            					<div>${HTML_SPACE}</div>
            				</td>
            			</tr>
					</tbody>
      			</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeInstructionshsr instructionshsr>
	<#assign styleFontFamily = "font-family: tahoma, arial, sans-serif;">
	<#if (instructionshsr??) && (instructionshsr?size > 0)>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:left; background:#FFFFFF;">
					<tbody>
						<tr>
							<td style=" border-bottom: 1pt solid #B4C1C6;">
	            				<div>${HTML_SPACE}</div>
    		        		</td>
						</tr>
						<#list instructionshsr as item>
							<tr>
								<td valign:"top">
									<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;">
										${item}
									</div>
								</td>
							</tr>
						</#list>
						<tr>
            				<td style=" border-top: 1pt solid #B4C1C6;">
            					<div>${HTML_SPACE}</div>
            				</td>
            			</tr>
					</tbody>
      			</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeItemdetails itemdetails>
	<#if (itemdetails??) && (itemdetails?size > 0)>
		<#assign styles_for_border = "" >
		<#assign i=0 >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; font-weight:normal; line-height: 30px; text-align:left; color:#404040; background:#FFFFFF;">
    	        	<tbody>
        	    		<tr>
            				<td colspan="2">
            					<div style=" color:#475156; font-size:18px; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; ">
            						${replaceWithConstant('Item Details')}
            					</div>
            				</td>
            			</tr>
            			<#list itemdetails as data>
							<#assign styles_for_border = "border-top: 1pt solid #B4C1C6;" >
            				<#assign i=i+1 >
            				<#if (data??) && (data?size >1) >
            					<#if (data?size >0) >
            						<tr>
            							<td class="tdcolumn" style="${styles_for_border}" valign="top" width="${precentToPixelConverter(25)}">
            								<div style=" margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;">
            									${replaceWithConstant(data[0])}
            								</div>
            							</td>
            							<#if data_index = 0>
	            							<td style="${styles_for_border}" valign:"top" width="${precentToPixelConverter(75)}">
		            							<div style="margin-left:5px; margin-right:5px; text-align:right; font-family:tahoma,arial,sans-serif;">
	    	        								${replaceWithConstantForItemType(data[1])}
	        	    							</div>
	            							</td>
            							<#else>
            								<td style="${styles_for_border}" valign:"top" width="${precentToPixelConverter(75)}">
	            								<div style="margin-left:5px; margin-right:5px; text-align:right; font-family:tahoma,arial,sans-serif;">
    	        									${data[1]}
        	    							</div>
            							</td>
            							</#if>
            						</tr>
            					<#else>
            						<tr>
            							<td style="border-top: 1pt solid #B4C1C6;" colspan="2">
            								<div>${HTML_SPACE}</div>
            							</td>
            							<#assign i =0>
            						</tr>
            					</#if>
            				</#if>
						</#list>
						<tr>
							<td style="border-top: 1pt solid #B4C1C6;" colspan="2">
								<div>${HTML_SPACE}</div>
							</td>
						</tr>
            		</tbody>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeCompliancewarning compliancewarning>
	<#if (compliancewarning??) && (compliancewarning?size > 0)>
		<#assign styles_for_border = "" >
		<#assign i=0 >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="color: #475156; margin: 0 24px; width: 552px; font-size:12px; font-weight:normal; text-align:left; background:#FFFFFF;">
					<tbody>
            			<tr>
            				<td valign="top" colspan="2" style="background: #FCEEDB;">
            					<div style="color:#EC971F; font-size:15px; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;  ">
            						${replaceWithConstant('Compliance Warning')}
            					</div>
            				</td>
            			</tr>
            			<#list compliancewarning as data>
            				<#assign i=i+1 >
            				<tr>
            					<td style="background: #FCEEDB;"  width="${precentToPixelConverter(25)}" valign="top">
	            					<div style="line-height: 25px; color: #9b9b9b; font-weight: bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;">
    	        						${replaceWithConstant(data[0])}
        	    					</div>
	            				</td>
    	        				<td style="background: #FCEEDB;" width="${precentToPixelConverter(75)}" valign="top">
        	    					<div style="line-height: 25px; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:447px;">
            							${data[1]}
            						</div>
	            				</td>
    	        			</tr>
        	    		</#list>
            			<tr>
            				<td valign="top", colspan="2">
            					<div> ${HTML_SPACE} </div>
            				</td>
            			</tr>
            		</tbody>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeExpensedetails_ expensedetails_>
	<#if (expensedetails_??) && (expensedetails_?size > 0)>
		<#local j=0, k=0, n=0, p=0, l=0 >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; font-weight:normal; text-align:left; color:#404040; background:#FFFFFF;">
					<tbody>
            			<tr>
            				<td colspan="4">
            					<div style=" color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; ">
            						${replaceWithConstant('Expense Details')}
            					</div>
            				</td>	
            				<#list expensedetails_ as data>
            					<#switch data?size>
	            					<#case 0>
    	        						<#if (j>0) || (k>0) || (n>0) || (p>0) || (l>0) >
        	    							<tr>
            									<td style="border-top: 1pt solid #B4C1C6;" colspan="4">
            										<div> ${HTML_SPACE} </div>
            									</td>
            								</tr>
            								<#local j=0, k=0, n=0, p=0, l=0 >
            							</#if>
            							<#break>
            						<#case 1>
            							<tr>
            								<td style="border-top: 1pt solid #B4C1C6;" valign="top" colspan="4">
            									<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;">
            										${data[0]}
            									</div>
            								</td>
            							</tr>
            							<#local k=k+1 >
            							<#break>
            						<#case 2>
            							<tr>
											<td class="tdcolumn" style="border-top: 1pt solid #B4C1C6;" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:119px;">
													${replaceWithConstant(data[0])}
												</div>
											</td>
											<td style="border-top: 1pt solid #B4C1C6;" valign="top" colspan="3" width="${precentToPixelConverter(80)}">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:477px;">
													${data[1]}
												</div>
											</td>
            							</tr>
            							<#local l=l+1 >
            							<#break>
            						<#case 3>
            							<tr>
											<td style="border-top: 1pt solid #B4C1C6;" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
												<div style=" margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;">
													${replaceWithConstant(data[0])}
												</div>
											</td>
											<td style="border-top: 1pt solid #B4C1C6;" valign="top" colspan="1" width="${precentToPixelConverter(30)}">
            									<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;max-width:179px;">
            										${data[1]}
            									</div>
            								</td>
											<td style="border-top: 1pt solid #B4C1C6;" valign="top" colspan="2" width="${precentToPixelConverter(50)}">
												<div style=" margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:298px;">
													${data[2]}
												</div>
											</td>
            							</tr>
            							<#local p=p+1 >
            							<#break>
            						<#case 4>
            							<tr>
											<td style="border-top: 1pt solid #B4C1C6;" valign="top" width="${precentToPixelConverter(20)}">
            									<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;">
            										${data[0]}
            									</div>
            								</td>
											<td style="border-top: 1pt solid #B4C1C6;" valign="top" width="${precentToPixelConverter(30)}">
            									<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;max-width:179px;">
            										${data[1]}
            									</div>
            								</td>
											<td style="border-top: 1pt solid #B4C1C6;" valign="top" width="${precentToPixelConverter(30)}">
            									<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;max-width:179px;">
            										${data[2]}
            									</div>
            								</td>
											<td style="border-top: 1pt solid #B4C1C6;" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
            									<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; min-width:90px; max-width:119px;">
            										${data[3]}
            									</div>
            								</td>
            							</tr>
            							<#local n=n+1 >
            					<#break>
            					<#case 5>
            						<tr>
            							<td colspan="4">
            								<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; font-size: 13px;; font-weight:normal; text-align:left; color:#404040; background:#FFFFFF;">
												<tbody>
													<#if j=0>
													<tr>
														<td style=" border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;">
															<div style=" text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; ">
																${replaceWithConstant('Internal Guests')}
															</div>
														</td>
														<td style=" border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;">
															<div style=" text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; ">
																${replaceWithConstant('External Guests')}
															</div>
														</td>
														<td style=" border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;">
															<div style=" text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; ">
																${replaceWithConstant('Guests')}
															</div>
														</td>
														<td style=" border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;">
															<div style=" text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; ">
																${replaceWithConstant('Total Cost')}
															</div>
														</td>
														<td style=" border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;">
															<div style=" text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; ">
																${replaceWithConstant('Per Person')}
															</div>
														</td>
													</tr>
													
													</#if>
													<tr>
														<td valign="top" width="${precentToPixelConverter(25)}">
															<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(25)}px;">
																${data[0]}
															</div>
														</td>
														<td valign="top" width="${precentToPixelConverter(25)}">
															<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(25)}px;">
																${data[1]}
															</div>
														</td>
														<td valign="top" width="${precentToPixelConverter(10)}">
															<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(10)}px;">
																${data[2]}
															</div>
														</td>
														<td valign="top" width="${precentToPixelConverter(20)}">
															<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(20)}px;">
																${data[3]}
															</div>
														</td>
														<td valign="top" width="${precentToPixelConverter(20)}">
															<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(20)}px;">
																${data[4]}
															</div>
														</td>
													</tr>
													</tbody>
												</table>
            								</td>
            							</tr>
            							<#local j=j+1 >
            						<#break>
            						<#default>
            					</#switch>
            				</#list>
            			</tr>
            		</tbody>	
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeExpensedetails listdata>
	<#if listdata?has_content>
		<#local style_td="${BLANK}" >
		<#local styles_for_border="${BLANK}" >
		<#local i=0 >
		<#local j=0 >
		<#local border_td= true >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:left; font-size: 13px; color:#404040; background:#FFFFFF;">
					<tr>
						<td colspan="5">
							<@divData style="color:#475156; font-size:18px; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${replaceWithConstant('Expense Details')}" />
						</td>
					</tr>
					<#list listdata as row>
						<#local styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#local i = i + 1>
						<#if row?? && (row?size>3)>
							<#if row[0]?length = 0>
								<#local style_td= "border-top: 1pt solid #B4C1C6;">
								<#local border_td= false >
								<tr>
									<td class="tdcolumn" style="${styles_for_border}${style_td}" valign="top" colspan="1" width="${precentToPixelConverter(20)}/>">
										<div style=" margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:119px;">
											${row[1]}
										</div>
									</td>
									<td style="${styles_for_border}${style_td} valign="top" colspan="4" width="${precentToPixelConverter(80)}">
										<div style="  margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:477px;">
											${row[2]}
										</div>
									</td>
								</tr>
								<#local j = 0>
							<#else>
								<#if row?length = 5>
									<#if j = 0 >
										<tr>
											<td style ="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" >
												<@divData style="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="Internal Guests" />
											</td>
											<td style = "border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" >
												<div style=" text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													External Guests
												</div>
											</td>
											<td style = "border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" >
												<div style="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													Guests
												</div>
											</td>
											<td style = "border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" >
												<div style="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													Total Cost
												</div>
											</td>
											<td style = "border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6;" >
												<div style="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													Per Person
												</div>
											</td>
										</tr>
										<tr>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;text-align:right;">
													${row[0]}
												</div>
											</td>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;text-align:right;">
													${row[1]}
												</div>
											</td>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;text-align:right;">
													${row[2]}
												</div>
											</td>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;text-align:right;">
													${row[3]}
												</div>
											</td>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;text-align:right;">
													${row[4]}
												</div>
											</td>
										</tr>
									<#else>
										<tr>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													${row[0]}
												</div>
											</td>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													${row[1]}
												</div>
											</td>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													${row[2]}
												</div>
											</td>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													${row[3]}
												</div>
											</td>
											<td valign:"top">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
													${row[4]}
												</div>
											</td>
										</tr>
									</#if>
									<#local j = j + 1>
								</#if>
								<#if !border_td >
									<#local style_td= "border-top: 1pt solid #B4C1C6;">
									<#local border_td= true >
									<tr>
										<td border-top: 1pt solid #B4C1C6;" ,colspan:"5">
											<div> ${HTML_SPACE} </div>
										</td>
									</tr>
								<#else>
									<#local style_td= "">
								</#if>
								<#if (row[1]?length > 0) >
									<#if row[0]?length =1 >
										<tr>
											<td style="${style_td}${styles_for_border}" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;">
													${row[0]}
												</div>
											</td>
											<td style="${style_td}${styles_for_border}" valign="top" colspan="1" width="${precentToPixelConverter(30)}" >
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;">
													${row[1]}
												</div>
											</td>
											<td style="${style_td}${styles_for_border}" valign="top" colspan="1" width="${precentToPixelConverter(50)}" >
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:298px;">
													${row[2]}
												</div>
											</td>
										</tr>
									<#else>
										<tr>
											<td style="${style_td}${tyles_for_border}" valign="top" width="${precentToPixelConverter(20)}" >
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;">
													${row[0]}
												</div>
											</td>
											<td style="${style_td}${styles_for_border}" valign="top" width="${precentToPixelConverter(30)}" >
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;">
													${row[1]}
												</div>
											</td>
											<td style="${style_td}${styles_for_border}" valign="top" width="${precentToPixelConverter(30)}" >
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:298px;">
													${row[2]}
												</div>
											</td>
											<td style="${style_td}${styles_for_border}" valign="top" width="${precentToPixelConverter(20)}" >
												<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; min-width:90px; max-width:119px;">
													${row[3]}
												</div>
											</td>
										</tr>
									</#if>
								<#else>
									<tr>
										<td style="${style_td}${styles_for_border}" valign="top" colspan="5">
											<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;">
												${row[0]}
											</div>
										<td>
									</tr>
								</#if>
							</#if>
						</#if>
					</#list>
					<tr>
						<td style="border-top: 1pt solid #B4C1C6;", valign="top", colspan="5">
							<div>${HTML_SPACE}</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeInstructioninbottom args>
	<#if args?? && (args?size > 1)>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="margin: 0 24px; width: 552px; text-align:center; font-size: 13px; color:#404040;">
					<tr>
						<td valign="top">
							<div style="font-family:tahoma,arial,sans-serif; max-width:36px; -webkit-text-size-adjust:none; margin-left:5px; margin-right:5px;">
								<@spanData /><@spanData /><@spanData /><@spanData /><@spanData />
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="2">
							<div style="font-family:tahoma,arial,sans-serif; max-width:596px; -webkit-text-size-adjust:none; margin-left:5px; margin-right:5px;">
								<@spanData value="${replaceWithConstant('instructions1')}" />
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<div style="font-family:tahoma,arial,sans-serif; max-width:36px; -webkit-text-size-adjust:none; margin-left:5px; margin-right:5px;">
								<@spanData /><@spanData /><@spanData /><@spanData /><@spanData />
							</div>
						</td>
						<td valign="top">
							<div style="font-family:tahoma,arial,sans-serif; max-width:560px; -webkit-text-size-adjust:none; margin-left:5px; margin-right:5px;">
								<@spanData value="${replaceWithConstant('instructions2')}"/><b>${replaceWithConstant('accept')}</b><@spanData value="${replaceWithConstant('or')}"/><b>${replaceWithConstant('return')}</b><@spanData value="${replaceWithConstant('instructions3')}"/>
								<br/>
								<@spanData value="- OR "/><b>${replaceWithConstant('forward')}</b><@spanData value="${replaceWithConstant('instructions4')}"/>
								<u style="color:#475156; text-decoration:underline; font-family:tahoma,arial,sans-serif;  -webkit-text-size-adjust:none;">${args[0]}</u>
								<@spanData value=" or "/>
								<u style="color:#475156; text-decoration:underline; font-family:tahoma,arial,sans-serif;  -webkit-text-size-adjust:none;">${args[1]}</u>
								<@spanData value="${replaceWithConstant('instructions5')}"/>
								<br/>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeInstructionsUrl Instructions_URL instructionsText>
	<tr>
    	<td>
        	<table cellpadding="0" cellspacing="0" width="100%" style="color:#9FA4A6;">
	            <#if Instructions_URL??>
	                <tr>
	                    <td colspan="2" height="12" />
	                </tr>
	                <tr>
	                    <td style="padding-left:0;padding-right:5.4pt;text-align:center;" colspan="2" valign="top" >
	                        <div style="margin-left:0;margin-right:0;font-family:tahoma,arial,sans-serif;font-size:12px;">
	                            <#if instructionsText?? && instructionsText?has_content >
 									<@spanData value="${replaceWithConstantAllowingDots(instructionsText)}" />
 								<#else>
 									<@spanData value="${getMessageProperty(commonPrefix + keyPrefix + 'instructionsViewReportText_url')}" />
 								</#if>
 	                            <a href="${getURLWithPrefix(Instructions_URL)}" style="∂text-decoration:none; font-family:tahoma,arial,sans-serif; ">
	                                <span style="color:#58C4D7; text-decoration:underline; font-style:italic; -webkit-text-size-adjust:none;">
	                                	<@spanData value="${getMessageProperty(commonPrefix + keyPrefix + 'click_here')}"/>
									</span>
	                            </a>
	                            <div>
									<br/>
								</div>
	                        </div>
	                    </td>
	                </tr>
	            </#if>
           </table>
   	   </td>
   </tr>
</#macro>

<#macro writeEmailrow listdata>
	<#if listdata?has_content>
		<#list listdata as row>
			<#if row?? && (row?size<1)>
				<tr>
					<td valign="top" width="100%">
						<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;" value="${row[0]}" />						
					</td>
				</tr>
			<#else>
				<tr>
					<td valign="top" width="100%">
						<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;">${replaceWithConstant(row[0])}
							<u style="color:#475156; text-decoration:underline; font-family:tahoma,arial,sans-serif;">${row[1]}</u>
						</div>						
					</td>
				</tr>
			</#if>
		</#list>
	</#if>
</#macro>

<#macro writeCombinedemailrows listdata>
	<#assign header=false>
	<@writeInforowswhichcontainsemails inforowswhichcontainsemails=listdata />
	<#assign header=true>
</#macro>

<#macro writeSingleExpenseLineItemReturned name args>
	<#if args?? && (args?size>0)>
		<#local styles_for_border="border-top: 1pt solid #B4C1C6;">
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="line-height: 30px; margin: 0 24px; width: 552px; font-size: 13px;; color:#404040; text-align:right; background:#FFFFFF;">
					<tr>
						<@columnData width="${precentToPixelConverter(50)}" 
							divstyle="color:#475156; font-size:18pxt; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:149px;" data="${name}"/>
						<@columnData width="${precentToPixelConverter(50)}" 
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${BLANK}"/>
					</tr>
					<tr>
						<@columnData tdstyle="${styles_for_border}max-width:149px;" width="${precentToPixelConverter(35)}" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${replaceWithConstant('EXPENSE')}"/>
						<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(65)}"
							divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${replaceWithConstantForItemType(args[0])}"/>
					</tr>
					<tr>
						<@columnData tdstyle="${styles_for_border}max-width:149px;" width="${precentToPixelConverter(35)}" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${replaceWithConstant('Date')}"/>
						<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(65)}"
							divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${args[1]}"/>
					</tr>
					<tr>
						<@columnData tdstyle="${styles_for_border}max-width:149px;" width="${precentToPixelConverter(35)}" 
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${replaceWithConstant('Amount')}"/>
						<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(65)}"
							divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${args[2]} ${args[3]}"/>
					</tr>
					<#local notes=args[4]>
					<#list notes as note>
						<tr>
							<#if note_index = 0>
								<@columnData tdstyle="${styles_for_border} max-width:149px; text-align: left;" width="${precentToPixelConverter(25)}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${replaceWithConstant('Notes')}"/>
							<@columnData tdstyle="${styles_for_border} margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" width="${precentToPixelConverter(75)}" 
								divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${note}"/>
							<#else>
								<@columnData tdstyle="max-width:149px;" width="${precentToPixelConverter(25)}" 
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${BLANK}"/>
							<@columnData tdstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" width="${precentToPixelConverter(75)}" 
								divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px;" data="${note}"/>
							</#if>
						</tr>
					</#list>
					<tr>
						<td style="border-top: 1pt solid #B4C1C6;" colspan="2">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeExpenseLinesItemReturned listdata>
	<#if listdata?has_content>
		<#list listdata as row>
			<#if row_index = 0>
				<@writeSingleExpenseLineItemReturned name="${replaceWithConstant('Item Notes')}" args=row />
			<#else>
				<@writeSingleExpenseLineItemReturned name="${BLANK}" args=row />
			</#if>
		</#list>
	</#if>
</#macro>