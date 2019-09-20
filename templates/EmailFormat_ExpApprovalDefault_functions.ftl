<#macro divWithLabelValue label="${BLANK}" value="${BLANK}" style="">
	<div style="${style}">
		${label}: ${value}
	</div>
</#macro>

<#macro spanData value="${HTML_SPACE}" style="${BLANK}">
	<span style="${style}">${value}</span>
</#macro>

<#macro divData style='text-align:left; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;' value="${BLANK}">
	<div style="${style}">${value}</div>
</#macro>

<#macro dataDIVRow tdstyle="" divstyle="" valign="top" data="${HTML_SPACE}">
	<tr>
		<@columnData tdstyle="${tdstyle}" divstyle="${divstyle}" valign="${valign}" data="${data}"/>
	</tr>
</#macro>

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

<#function replaceWithConstant var>
	<#return removeSpecialCharactersAndFormKey(var, keyPrefix)>
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

<#function precentToPixelConverter percent width=table_width>
	<#return ((percent*width)/100)?round?string >
</#function>

<#macro columnData tdstyle="" divstyle="" valign="top" data="${HTML_SPACE}" width="${BLANK}">
	<#if (width?length>0)>
		<td valign="${valign}" style="${tdstyle}" width="${width}">
			<@divData style="${divstyle}" value="${data}" />
		</td>
	<#else>
		<td valign="${valign}" style="${tdstyle}">
			<@divData style="${divstyle}" value="${data}" />
		</td>
	</#if>
</#macro>

<#macro writeID label="${HTML_SPACE}" value="" footer=false>
	<#if value?? && (value?length>1)>
	    <tr>
	    	<td align='right' valign='top' width='100%'>
	    		<@divWithLabelValue label="${label}" value="${value}" style="text-align:right; margin-left:5px; margin-right:5px; padding-bottom:2px; padding-top:2px; font-family:tahoma,arial,sans-serif;"/>
	    		<#if footer>
	    			<br/>
	    		</#if>
	    	</td>
	    </tr>
    </#if>
</#macro>

<#macro writeHeader value>
	<#if value?has_content && (value?size>1)>
		<tr>
			<td>
				<table cellpadding='0' cellspacing='0' width='100%' style='background:#0089B7; color:#FFFFFF; font-size:12pt;'>
					<tr>
						<td style='border-bottom: 1pt solid #B4C1C6;' valign='top'>
							<@divData style="text-align:left; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${replaceWithConstant(value[0])}" />
						</td>
						<td style='border-bottom: 1pt solid #B4C1C6;' valign='top'>
							<@divData style="text-align:right; font-weight:normal; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${value[1]}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeBottompage>
	<tr>
		<td style="${hasline?string('border-top: 1pt solid #B4C1C6;','')}">
			<div>${HTML_SPACE}</div>
		</td>
	</tr>
</#macro>

<#macro writeInstruction value Instructions_URL InstructionsViewReportText_URL IsWatcherNotification = false>
	<#if IsWatcherNotification>
		<#local watcherInstructionKey = "expense.email.text.watcherInstructions">
		<#local watcherInstructionValue = getMessageProperty(watcherInstructionKey)>
		<#if !watcherInstructionValue?contains(watcherInstructionKey)>
		    <#local value = watcherInstructionValue>
	    </#if>
	</#if>
	<#if value?? && (value?length>0)>
		<tr>
			<td colspan="2">
				<table cellpadding="0" cellspacing="0" width="100%" style="text-align:left; font-size:9pt; color:#404040; background:"${topinfo?string("#FFFFFF;","#EBEEF0;")}>
					<#if topinfo>
						<@writeBottompage />
					</#if>
					<#assign splitValue = value?replace("<BR>","<br>")?split("<br>")>
					<#if splitValue?? && splitValue?has_content>
						<#list splitValue as split>
							<#if split?? && split?length=0>
								<td valign="top">
									<div style="font-family:tahoma,arial,sans-serif; max-width:596px; margin-left:5px; margin-right:5px;">
										<@spanData />
									</div>
								</td>
							<#else>
								<td valign="top">
									<div style="font-family:tahoma,arial,sans-serif; max-width:596px; margin-left:5px; margin-right:5px;">
										<@spanData value=split />
									</div>
								</td>
							</#if>
						</#list>
					</#if>
					<#if !IsWatcherNotification>
						<#if InstructionsViewReportText_URL?? && (InstructionsViewReportText_URL?length>0)>
							<#local effectiveText = InstructionsViewReportText_URL>
						<#else>
							<#local effectiveText = getMessageProperty("expense.email.text.instructionsViewReportText_url")>
						</#if>
						<#if Instructions_URL?? && (Instructions_URL?length>0)>
							<#local effectiveUrl = Instructions_URL>
						<#else>
							<#local effectiveUrl = "https://app.chromeriver.com">
						</#if>
						<tr>
							<td valign="top" colspan="2">
								<div style="font-family:tahoma,arial,sans-serif; max-width:596px; margin-left:5px; margin-right:5px;">
									<br/>
									<@spanData value=effectiveText />
									<a href="${effectiveUrl}" style="text-decoration:underline; font-family:tahoma,arial,sans-serif;">
										<@spanData value="${getMessageProperty('expense.email.text.click_here')}" />
									</a>
									<@spanData value="." />
								</div>
							</td>
						</tr>
					</#if>
					<#if topinfo>
						<@writeBottompage />
					</#if>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeDefaultinstruction args Instructions_URL InstructionsViewReportText_URL>
	<#if args?? && args?has_content && (args?size>1)>
		<#-- Info row which contains emails -->
		<tr>
			<td colspan="2">
				<table cellpadding="0" cellspacing="0" width="100%" style="text-align:left; font-size:9pt; color:#404040; background:${topinfo?string("#FFFFFF;","#EBEEF0;")}">
					<#if topinfo>
						<@writeBottompage />
					</#if>
					<tr>
						<td valign="top" colspan="2">
							<div style="font-family:tahoma,arial,sans-serif; max-width:596px; margin-left:5px; margin-right:5px;">
								<@spanData value="${replaceWithConstant('instructions1')}" />
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<div style="font-family:tahoma,arial,sans-serif; max-width:36px; margin-left:5px; margin-right:5px;">
								<@spanData /><@spanData /><@spanData /><@spanData />
							</div>
						</td>
						<td valign="top">
							<div style="font-family:tahoma,arial,sans-serif; max-width:560px; margin-left:5px; margin-right:5px;">
								<@spanData value="${replaceWithConstant('instructions2')}"/><b>${replaceWithConstant('accept')}</b><@spanData value="${replaceWithConstant('or')}"/><b>${replaceWithConstant('return')}</b><@spanData value="${replaceWithConstant('instructions3')}"/>
								<br/>
								<@spanData value="${replaceWithConstant('instructions6')}"/><b>${replaceWithConstant('forward')}</b><@spanData value="${replaceWithConstant('instructions4')}"/>
								<a href="" style="color:#404040;  text-decoration:none; font-family:tahoma,arial,sans-serif;">
									<span style="color:#404040;  text-decoration:none; font-family:tahoma,arial,sans-serif;">
										${args[0]}
									</span>
								</a>
								<@spanData value="${replaceWithConstant('instructions7')}"/>
								<a href="" style="color:#404040;  text-decoration:none; font-family:tahoma,arial,sans-serif;">
									<span style="color:#404040;  text-decoration:none; font-family:tahoma,arial,sans-serif;">
										${args[1]!BLANK}
									</span>
								</a>
								<@spanData value="${replaceWithConstant('instructions5')}"/>
							</div>
						</td>
					</tr>
					<#if InstructionsViewReportText_URL?? && (InstructionsViewReportText_URL?length>0)>
						<#local effectiveText = InstructionsViewReportText_URL>
					<#else>
						<#local effectiveText = getMessageProperty("expense.email.text.instructionsViewReportText_url")>
					</#if>
					<#if Instructions_URL?? && (Instructions_URL?length>0)>
						<#local effectiveUrl = Instructions_URL>
					<#else>
						<#local effectiveUrl = "https://app.chromeriver.com">
					</#if>
					<tr>
						<td valign="top" colspan="2">
							<div style="font-family:tahoma,arial,sans-serif; max-width:596px; margin-left:5px; margin-right:5px;">
								<br/>
								<@spanData value=effectiveText />
								<a href="${effectiveUrl}" style="text-decoration:underline; font-family:tahoma,arial,sans-serif;">
									<@spanData value= getMessageProperty("expense.email.text.click_here") />
								</a>
								<@spanData value="." />
							</div>
						</td>
					</tr>
					<#if topinfo>
						<@writeBottompage />
					</#if>
				</table>
			</td>
		</tr>
	</#if>
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
                                 &body=%0D%0A--------------------------------------%0D%0A${getMessageProperty('expense.email.text.pre-approval_accept_response_email_text')?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant('Pre-Approval ID')}:${expense.reportId}">${replaceWithConstant('ACCEPT')}</a>
						</td>
						<td width="${precentToPixelConverter(10)}" align="center" valign="middle">
							<br/>
						</td>
						<td width="${precentToPixelConverter(20)}" style="padding-top:5px; padding-bottom:5px; background:#DB5947; border: 2pt solid #C00000; min-width:100px; max-width:115px;" align="center" valign="middle">
							<a style="font-family:tahoma,arial,sans-serif; font-size:11pt; font-weight:bold; color:white; background:#DB5947; text-decoration:none;" href="mailto:${listdata[1]}?subject=${replaceWithConstant('Chrome River Pre-Approval Request')} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]+
                                 &body=%0D%0A--------------------------------------%0D%0A${getMessageProperty('expense.email.text.pre-approval_accept_response_email_text')?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant('Pre-Approval ID')}:${expense.reportId}">${replaceWithConstant('RETURN')}</a>
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
							&body=%0D%0A--------------------------------------%0D%0A${getMessageProperty('expense.email.text.approval_accept_response_email_text')?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant('Report ID')}: ${expense.reportId} ${replaceWithConstant('Email UID')}: ${expense.emailVersionUID!''}'>${replaceWithConstant('ACCEPT')}</a>
						</td>
						<td width="${precentToPixelConverter(10)}" align='center' valign='middle'>
							<br/>
						</td>
						<td width="${precentToPixelConverter(20)}" style='padding-top:5px; padding-bottom:5px; background:#DB5947; border: 2pt solid #C00000; min-width:100px; max-width:115px;' align='center' valign='middle'>
							<a style="font-family:tahoma,arial,sans-serif; font-size:11pt; font-weight:bold; color:white; background:#DB5947; text-decoration:none;" href='mailto:${button[1]}?subject=${replaceWithConstant('Chrome River Expense Approval')} [${expense.firstName?replace("&","%26")?xhtml} ${expense.lastName?replace("&","%26")?xhtml}]
							&body=%0D%0A--------------------------------------%0D%0A${getMessageProperty('expense.email.text.approval_return_response_email_text')?replace("'","%27")?xhtml}%0D%0A--------------------------------------%0D%0A${replaceWithConstant('Report ID')}: ${expense.reportId} ${replaceWithConstant('Email UID')}: ${expense.emailVersionUID!''}'>${replaceWithConstant('RETURN')}</a>
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

<#macro writeExpenseRow expenserowdata>
	<#if (expenserowdata?has_content)>
		<#local width_td = 25 >
		<tr>
	    	<td>
	            <table cellpadding="0" cellspacing="0" align="center" width="100%" style="font-size:9pt; font-weight:normal; color:#404040; background:#FFFFFF;">
	            	<#list expenserowdata as expenserow>
	            		<#if (expenserow??) && (expenserow?size > 1)>
	            			<#if expenserow[0]?? && expenserow[1]??>
	            				<#local nbsp = false>
            				<#else>
            					<#local nbsp = true>
	            			</#if>
	            			<#if (expenserow[0]?matches('Pre-Approval Request For'))>
            					<#local width_td = 35 >
            				</#if>
            				<#if expenserow_index = 0>
            					<tr>
            						<td id="tdcol" style="background:#DBEEF4; border-top: 1pt solid #B4C1C6;" valign="top" width="${precentToPixelConverter(width_td)}">
            							<@divData style="text-align:right; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:${precentToPixelConverter(width_td)}px;" value="${nbsp?string(HTML_SPACE,replaceWithConstant(expenserow[0]))}" />
            						</td>
            						<td style="border-top: 1pt solid #B4C1C6;" valign="top" width="${precentToPixelConverter(100-width_td)}">
            							<@divData style="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;max-width:${precentToPixelConverter((100-width_td))}px;"
										value="${nbsp?string(HTML_SPACE,(expenserow?size>2)?string(expenserow[1]?replace('{0}', (replaceWithConstant(expenserow[2]!BLANK)?has_content)?string(' ' + replaceWithConstant(expenserow[2]!BLANK), BLANK)), expenserow[1]))}" />
            						</td>
            					</tr>
        					<#else>
        						<tr>
            						<td class="tdcol" style="background:#DBEEF4;" valign="top" width="${precentToPixelConverter(width_td)}">
            							<@divData style="text-align:right; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:${precentToPixelConverter(width_td)}px;" value="${nbsp?string(HTML_SPACE,replaceWithConstant(expenserow[0]))}" />
            						</td>
            						<td  valign="top" width="${precentToPixelConverter(100-width_td)}">
            							<@divData style="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;max-width:${precentToPixelConverter(100-width_td)}px;"
										value="${nbsp?string(HTML_SPACE,(expenserow?size>2)?string(expenserow[1]?replace('{0}', (replaceWithConstant(expenserow[2]!BLANK)?has_content)?string(' ' + replaceWithConstant(expenserow[2]!BLANK), BLANK)), expenserow[1]))}" />
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

<#macro writeCompliancewarning compliancewarning>
	<#if (compliancewarning??) && (compliancewarning?size > 0)>
		<#local styles_for_border = "" >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="font-size:9pt; color:#404040; text-align:left; background:#FFFFFF;">
					<tbody>
            			<tr>
            				<td valign="top" colspan="2">
            					<div style="color:#C00000; font-size:10pt; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
            						${replaceWithConstant('Compliance Warning')}
            					</div>
            				</td>
            			</tr>
            			<#list compliancewarning as data>
            				<#if data_index = 0>
            					<#local styles_for_border = "border-top: 1pt solid #B4C1C6;" >
            				<#else>
            					<#local styles_for_border = "" >
            				</#if>
            				<tr>
            					<td class="tdcolumn" style="background:#EBEEF0;${styles_for_border}"  width="${precentToPixelConverter(25)}" valign="top">
	            					<div style="margin-left:5px; margin-right:5px; text-align:right; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:149px;">
    	        						${replaceWithConstant(data[0])}
        	    					</div>
	            				</td>
    	        				<td style="${styles_for_border}" width="${precentToPixelConverter(75)}" valign="top">
        	    					<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:447px;">
            							${data[1]}
            						</div>
	            				</td>
    	        			</tr>
        	    		</#list>
            			<tr>
            				<td style="border-top: 1pt solid #B4C1C6;" valign="top", colspan="2">
            					<div> ${HTML_SPACE} </div>
            				</td>
            			</tr>
            		</tbody>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeNotes listdata>
	<#if (listdata??) && (listdata?size > 0)>
		<#local styles_for_border = "" >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="font-size:9pt; color:#404040; text-align:left; background:#FFFFFF;">
					<tbody>
            			<tr>
            				<td valign="top" colspan="2">
            					<div style="color:#0089B7; font-size:10pt; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
            						${replaceWithConstant('Report Notes')}
            					</div>
            				</td>
            			</tr>
            			<#list listdata as data>
            				<#if data_index = 0>
            					<#local styles_for_border = "border-top: 1pt solid #B4C1C6;" >
            				<#else>
            					<#local styles_for_border = "" >
            				</#if>
            				<tr>
            					<td class="tdcolumn" style="background:#EBEEF0;${styles_for_border}"  width="${precentToPixelConverter(20)}" valign="top">
	            					<div style="margin-left:5px; margin-right:5px; text-align:right; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:149px;">
    	        						${data[0]}
        	    					</div>
	            				</td>
    	        				<td style="${styles_for_border}" width="${precentToPixelConverter(30)}" valign="top">
        	    					<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
            							${data[1]}
            						</div>
	            				</td>
	            				<td style="${styles_for_border}" width="${precentToPixelConverter(50)}" valign="top">
        	    					<div style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:447px;">
            							${data[2]}
            						</div>
	            				</td>
    	        			</tr>
        	    		</#list>
            			<tr>
            				<td style="border-top: 1pt solid #B4C1C6;" valign="top", colspan="3">
            					<div> ${HTML_SPACE} </div>
            				</td>
            			</tr>
            		</tbody>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeExpensepurpose name listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="text-align:left; font-size:9pt; color:#404040; background:#FFFFFF;">
					<@dataDIVRow tdstyle="" divstyle="color:#0089B7; font-size:10pt; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${name}"  />
					<#list listdata as row>
						<#if row_index = 0>
							<#local styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#else>
							<#local styles_for_border= "${BLANK}">
						</#if>
						<@dataDIVRow tdstyle="${styles_for_border}" divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;" data="${row}"  />
					</#list>
					<@dataDIVRow tdstyle="border-top: 1pt solid #B4C1C6;" divstyle="" data="${HTML_SPACE}"  />
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeExpenseaccountsummary name listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="text-align:left; font-size:9pt; color:#404040; background:#FFFFFF;">
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
							<@divData style="color:#0089B7; font-size:10pt; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${name}" />
						</td>
						<td colspan="1">
							<@divData style="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="${replaceWithConstant('Amount')} (${expense.currency})" />
						</td>
					</tr>
					<#list listdata as row>
						<#if row??>
							<#if row_index = 0>
								<#local styles_for_border= "border-top: 1pt solid #B4C1C6;">
							<#else>
								<#local styles_for_border= "${BLANK}">
							</#if>
							<#if row?size=1>
								<tr>
									<td colspan="${columns}" style="${styles_for_border}">
										<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;" value="${row[0]}" />
									</td>
								</tr>
							<#elseif row?size=4>
								<tr>
									<@columnData tdstyle="${styles_for_border}" width="${precentToPixelConverter(accountsummary4items[0])}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:79px;" data="${row[0]}"/>
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
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:79px;" data="${row[0]}"/>
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

<#macro writeSummaries name listdata>
	<#if listdata?has_content>
		<#local buf_array=(listdata[0])[1]?split(" ") >
		<#local currency="" >
		<#if buf_array?? && (buf_array?size>1) >
			<#local currency=buf_array[1] >
		</#if>
		<#if (currency?length>0)>
			<#local label="${replaceWithConstant('Amount')} (${currency})">
		<#else>
			<#local label="">
		</#if>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="font-size:9pt; color:#404040; text-align:right; background:#FFFFFF;">
					<tr>
						<@columnData width="${precentToPixelConverter(25)}"
							divstyle="color:#0089B7; font-size:10pt; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:149px;" data="${name}" />
						<@columnData width="${precentToPixelConverter(20)}"
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" data="${label}" />
						<td width="${precentToPixelConverter(55)}" valign='top'>
							<br/>
						</td>
					</tr>
					<#list listdata as row>
						<#if row_index = 0>
							<#local styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#else>
							<#local styles_for_border= "${BLANK}">
						</#if>
						<#if row?? && (row?size>1)>
							<tr>
								<@columnData tdstyle="background:#EBEEF0; max-width:149px;${styles_for_border};" width="${precentToPixelConverter(25)}"
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${replaceWithConstant(row[0])!BLANK}" />
								<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px;" data="${(row[1]?split(' '))[0]}" />
								<#if row?size=3>
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(55)}"
										divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:328px;" data="${row[2]}" />
								<#else>
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(55)}"
										divstyle="max-width:328px;" data="${HTML_SPACE}" />
								</#if>
							</tr>
						</#if>
					</#list>
					<tr>
						<td colspan="3" style="border-top: 1pt solid #B4C1C6;">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeUdadatadetail listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="font-size:9pt; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;"
							divstyle="color:#0089B7; font-size:10pt; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left;" data="${replaceWithConstant('Guest Details')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;"
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Name')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;"
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Company')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;"
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Guests')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;"
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Total Cost')}" />
						<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6;"
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Per Person')}" />
					</tr>
					<#list listdata as row>
						<#if row?? && (row?size>5)>
							<tr>
								<@columnData tdstyle="background:#EBEEF0;"
									divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstantForUDA(row[0])}" />
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

<#macro writeExpensedetails_ expensedetails_ listdataComplianceWarnings listdataNotes listdataReceipts>
	<#assign width_td = 50>
	<#if (expensedetails_?has_content)>
		<#local j=0, k=0, n=0, p=0, l=0, m=0 >
		<#local index = 0 >
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="text-align:left; font-size:9pt; color:#404040; background:#FFFFFF;">
					<tbody>
            			<tr>
            				<td colspan="4">
            					<div style="color:#0089B7; font-size:10pt; font-weight:bold; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;">
            						${replaceWithConstant('Expense Details')}
            					</div>
            				</td>
            				<#list expensedetails_ as block>
            					<#if (index>0)>
            						<tr>
            							<td style="border-bottom: 1pt solid #B4C1C6;" colspan="4">
            								<@divData style="" value="${HTML_SPACE}" />
            							</td>
            						</tr>
            					</#if>
								<#local j=0 >
								<#local m=0 >
            					<#if block?? && (block?size>0)>
            						<#list block as args>
            							<#if (args?size=0)>
            								<#if (k>0) || (l>0) || (p>0) || (j>0) || (n>0) || (m>0) >
	        	    							<tr>
	            									<td style="border-top: 1pt solid #B4C1C6;" colspan="4">
	            										<div> ${HTML_SPACE} </div>
	            									</td>
	            								</tr>
	            								<#local k=0, l=0, p=0, j=0, n=0, m=0 >
            								</#if>
        								<#else>
        									<#if args[0]?lower_case?matches('child')>
    											<#-- args[0] is always "child" so ignore -->
    											<#-- There is no case 0 or 1 for a child item -->
        										<#switch args?size>
        											<#case 2> <#-- actually case 1 -->
        												<tr>
        													<td style="${(k=0 && p=0 && n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="4">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;" value="${args[1]!BLANK}" />
        													</td>
        												</tr>
        												<#local k=k+1>
        											<#break>
        											<#case 3> <#-- actually case 2 -->
        												<tr>
        													<td class="tdcolumn" style="${(l=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="1" width="${precentToPixelConverter(24)}">
        														<@divData style="margin-left:20px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; width:100px; background:#EBEEF0; display: inline-block; padding-right: 5px" value="${replaceWithConstant(args[1]!BLANK )}" />
        													</td>
        													<td style="${(l=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="3" width="${precentToPixelConverter(76)}">
        														<@divData style="display: inline-block; padding-left: 5px" value="${replaceWithConstantForUDA(args[2]!BLANK )}" />
        													</td>
        												</tr>
        												<#local l=l+1>
        											<#break>
        											<#case 4> <#-- actually case 3 -->
        												<tr>
        													<td style="${(p=0 && n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
        														<@divData style="margin-left:20px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" value="${args[1]!BLANK}" />
        													</td>
        													<td style="${(p=0 && n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="1" width="${precentToPixelConverter(29)}">
        														<@divData style="margin-left:20px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;" value="${args[2]!BLANK}" />
        													</td>
        													<td style="${(p=0 && n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="2" width="${precentToPixelConverter(49)}">
        														<@divData style="margin-left:40px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:298px;" value="${args[3]!BLANK}" />
        													</td>
        												</tr>
        												<#local p=p+1>
        											<#break>
        											<#case 5> <#-- actually case 4 -->
        												<tr>
        													<td style="${(n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" width="${precentToPixelConverter(20)}">
        														<@divData style="margin-left:30px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" value="${args[1]!BLANK}" />
        													</td>
        													<td style="${(n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" width="${precentToPixelConverter(29)}">
        														<@divData style="margin-left:20px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;" value="${replaceWithConstantForItemType(args[2]!BLANK)}" />
        													</td>
        													<td style="${(n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" width="${precentToPixelConverter(29)}">
        														<@divData style="margin-left:40px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;" value="${args[3]!BLANK}" />
        													</td>
        													<td style="${(n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" width="${precentToPixelConverter(20)}">
        														<@divData style="margin-left:40px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; min-width:90px; max-width:119px;" value="${args[4]!BLANK}" />
        													</td>
        												</tr>
        												<#local n=n+1>
        											<#break>
        											<#case 6> <#-- actually case 5 -->
        												<tr>
        													<td colspan="5">
        														<table cellpadding="0" cellspacing="0" width="100%" style="text-align:left; font-size:9pt; color:#404040; background:#FFFFFF;">
        															<#if j=0>
        																<tr>
        																	<@columnData tdstyle="" width="12"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${HTML_SPACE}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Name')}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Company')}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Guests')}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Total Cost')}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Per Person')}"/>
        																</tr>
        															</#if>
        															<tr>
    																	<@columnData tdstyle="" width="${precentToPixelConverter(2)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(2)}px;" data="${BLANK}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(25)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(25)}px;" data="${args[1]!BLANK}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(25)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(25)}px;" data="${args[2]!BLANK}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(10)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(10)}px;" data="${args[3]!BLANK}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(19)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(19)}px;" data="${args[4]!BLANK}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(19)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(19)}px;" data="${args[5]!BLANK}"/>
    																</tr>
        														</table>
        													</td>
        												</tr>
        												<#local j=j+1>
        											<#break>
        											<#default>
        										</#switch>
    										<#else>
    											<#-- proceed as normal -->
												<#switch args?size>
        											<#case 1>
        												<tr>
        													<td style="${(k=0 && p=0 && n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="4">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:596px;" value="${args[0]}" />
        													</td>
        												</tr>
        												<#local k=k+1>
        											<#break>
        											<#case 2>
        												<tr>
        													<td class="tdcolumn" style="background:#EBEEF0;${(l=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:119px;" value="${replaceWithConstant(args[0])}" />
        													</td>
        													<td style="${(l=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="3" width="${precentToPixelConverter(80)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:477px;" value="${replaceWithConstantForUDA(args[1]!BLANK )}" />
        													</td>
        												</tr>
        												<#local l=l+1>
        											<#break>
        											<#case 3>
        												<tr>
        													<td style="${(p=0 && n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" value="${args[0]}" />
        													</td>
        													<td style="${(p=0 && n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="1" width="${precentToPixelConverter(30)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;" value="${args[1]!BLANK}" />
        													</td>
        													<td style="${(p=0 && n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" colspan="2" width="${precentToPixelConverter(50)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:298px;" value="${args[2]!BLANK}" />
        													</td>
        												</tr>
        												<#local p=p+1>
        											<#break>
        											<#case 4>
        												<tr>
        													<td style="${(n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" width="${precentToPixelConverter(20)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" value="${args[0]}" />
        													</td>
        													<td style="${(n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" width="${precentToPixelConverter(30)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;" value="${replaceWithConstantForItemType(args[1]!BLANK)}" />
        													</td>
        													<td style="${(n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" width="${precentToPixelConverter(30)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;" value="${args[2]!BLANK}" />
        													</td>
        													<td style="${(n=0)?string('border-top: 1pt solid #B4C1C6;', '')}" valign="top" width="${precentToPixelConverter(20)}">
        														<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; min-width:90px; max-width:119px;" value="${args[3]!BLANK}" />
        													</td>
        												</tr>
        												<#local n=n+1>
        											<#break>
        											<#case 5>
        												<tr>
        													<td colspan="4">
        														<table cellpadding="0" cellspacing="0" width="100%" style="text-align:left; font-size:9pt; color:#404040; background:#FFFFFF;">
        															<#if j=0>
        																<tr>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Name')}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Company')}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Guests')}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Total Cost')}"/>
																			<@columnData tdstyle="border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0;"
																				divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" data="${replaceWithConstant('Per Person')}"/>
        																</tr>
        															</#if>
        															<tr>
																		<@columnData tdstyle="" width="${precentToPixelConverter(25)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(25)}px;" data="${args[0]}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(25)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(25)}px;" data="${args[1]!BLANK}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(10)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(10)}px;" data="${args[2]!BLANK}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(20)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(20)}px;" data="${args[3]!BLANK}"/>
																		<@columnData tdstyle="" width="${precentToPixelConverter(20)}"
																			divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(20)}px;" data="${args[4]!BLANK}"/>
    																</tr>
        														</table>
        													</td>
        												</tr>
        												<#local j=j+1>
        											<#break>
        											<#-- MER-10764 to add Expense Matter VAT section -->
                                                    <#case 6>
                                                      <tr>
                                                          <td colspan="4">
                                                              <table cellpadding="0" cellspacing="0" width="100%" style="text-align:left; font-size:9pt; color:#404040; background:#FFFFFF;">
                                                                  <#if m=0>
                                                                      <tr>
                                                                          <td style=' border-bottom: 1pt solid #B4C1C6; border-top: 1pt solid #B4C1C6; background:#EBEEF0; ' width='${precentToPixelConverter(width_td)}' colspan='10'>
                                                                              <@divData style=' text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; ' value="${replaceWithConstant('Matter VAT')}" />
                                                                          </td>
                                                                      </tr>
                                                                  </#if>
                                                                  <tr>
                                                                      <@columnData tdstyle="" width="${precentToPixelConverter(25)}"
                                                                          divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(25)}px;" data="${args[1]!BLANK}"/>
                                                                      <@columnData tdstyle="" width="${precentToPixelConverter(25)}"
                                                                          divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:${precentToPixelConverter(25)}px;" data="${args[2]!BLANK}"/>
                                                                      <@columnData tdstyle="" width="${precentToPixelConverter(20)}"
                                                                          divstyle="white-space: pre-wrap; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:left; max-width:${precentToPixelConverter(20)}px;" data="${args[3]!BLANK}"/>
                                                                      <@columnData tdstyle="" width="${precentToPixelConverter(10)}"
                                                                          divstyle="white-space: pre-wrap; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(10)}px;" data="${args[4]!BLANK}"/>
                                                                      <@columnData tdstyle="" width="${precentToPixelConverter(20)}"
                                                                          divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:${precentToPixelConverter(20)}px;" data="${args[5]!BLANK}"/>
                                                                      </tr>
                                                              </table>
                                                          </td>
                                                      </tr>
                                                      <#local m=m+1>
                                                    <#break>
        											<#default>
        										</#switch>
        									</#if>
            							</#if>
            						</#list>
            						<#-- endfor lineitem -->

            						<#-- write receipts if any are present for current lineitem -->
            		            	<#if (listdataReceipts?size>index)>
            		         			<#local link=listdataReceipts[index]!>
	    								<#if link?has_content>
		    								<tr>
	        									<td class="tdcolumn" style="background:#EBEEF0;" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
	        										<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:119px;" value="${replaceWithConstant('receipts')}" />
	        									</td>
	        									<td valign="top" colspan="3" width="${precentToPixelConverter(80)}">
	        										<a href="${link}" style="color:#404040;  text-decoration:none; font-family:tahoma,arial,sans-serif;">
														<@spanData style="margin-left:5px; margin-right:5px; color:#0089B7; text-decoration:underline; font-family:tahoma,arial,sans-serif;  -webkit-text-size-adjust:none;" value="${replaceWithConstant('view')}" />
													</a>
	        									</td>
	        								</tr>
	        							</#if>
	        						</#if>

            						<#-- write notes and compliances if any present for current lineitem -->
            						<#local ind=0>
            						<#if (listdataComplianceWarnings?size>index)>
            							<#local complianceItems=listdataComplianceWarnings[index]>
        							<#else>
        								<#local complianceItems=[]>
    								</#if>
    								<#if complianceItems?has_content>
    									<tr>
    										<td style="border-top: 1pt solid #B4C1C6;" colspan="4">
    											<div style="color:#C00000; font-size:10pt; font-weight:bold; text-align:left; margin-left:5px; font-family:tahoma,arial,sans-serif;">
				            						${replaceWithConstant('Compliance Warning')}
				            					</div>
    										</td>
    									</tr>
    									<#list complianceItems as complianceItem>
    										<#if complianceItem?has_content>
    											<tr>
    												<td class="tdcolumn" style="background:#EBEEF0;${(ind=0)?string('border-top: 1pt solid #B4C1C6;','')}" valign="top" colspan="1" width="${precentToPixelConverter(25)}">
    													<#if complianceItem[0]?trim?lower_case=="response">
															<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:119px;" value="${replaceWithConstant(complianceItem[0])}" />
														<#else>
															<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; text-align:right; max-width:119px;" value="${replaceWithConstantForItemType(complianceItem[0])}" />
														</#if>
    												</td>
    												<td style="${(ind=0)?string('border-top: 1pt solid #B4C1C6;','')}" valign="top" colspan="3" width="${precentToPixelConverter(75)}">
    													<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:477px;" value="${complianceItem[1]}" />
    												</td>
    											</tr>
    											<#local ind=ind+1>
    										</#if>
    									</#list>
    								</#if>

    								<#if (listdataNotes?size>index)>
            							<#local itemNotes=listdataNotes[index]>
        							<#else>
        								<#local itemNotes=[]>
    								</#if>
    								<#if itemNotes?has_content>
    									<tr>
    										<td style="border-top: 1pt solid #B4C1C6;" colspan="4">
    											<div style="color:#C00000; font-size:10pt; font-weight:bold; text-align:left; margin-left:5px; font-family:tahoma,arial,sans-serif;">
				            						!! ${replaceWithConstant('Notes')} !!
				            					</div>
    										</td>
    									</tr>
    									<#local ind=0>
    									<#list itemNotes as itemNote>
    										<#if itemNote?has_content && (itemNote?size>1)>
    											<tr>
    												<td style="${(ind=0)?string('border-top: 1pt solid #B4C1C6;','')}" valign="top" colspan="1" width="${precentToPixelConverter(20)}">
    													<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" value="${itemNote[0]}" />
    												</td>
    												<td style="${(ind=0)?string('border-top: 1pt solid #B4C1C6;','')}" valign="top" colspan="1" width="${precentToPixelConverter(25)}">
    													<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:179px;" value="${itemNote[1]}" />
    												</td>
    												<td style="${(ind=0)?string('border-top: 1pt solid #B4C1C6;','')}" valign="top" colspan="1" width="${precentToPixelConverter(55)}">
    													<@divData style="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:298px;" value="${itemNote[2]}" />
    												</td>
    											</tr>
    											<#local ind=ind+1>
    										</#if>
    									</#list>
    								</#if>
            					</#if>
            					<#local index=index+1>
            					<tr>
            						<td style="border-top: 1pt solid #B4C1C6;" colspan="4">
            							<@divData style="" value="${HTML_SPACE}" />
            						</td>
            					</tr>
            				</#list>
            				<#-- end for multilevel -->
            			</tr>
            		</tbody>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeFinancialsummary listdata>
	<@writeSummaries name="${replaceWithConstant('Financial Summary')}" listdata=listdata />
</#macro>

<#macro writeAttorneyBudgetSummaries name listdata>
	<#if listdata?has_content>
		<#local buf_array=(listdata[1])[1]?split(" ") >
		<#local currency="" >
		<#if buf_array?? && (buf_array?size>1) >
			<#local currency=buf_array[1] >
		</#if>
		<#if (currency?length>0)>
			<#local label="${replaceWithConstant('Amount')} (${currency})">
		<#else>
			<#local label="">
		</#if>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="font-size:9pt; color:#404040; text-align:right; background:#FFFFFF;">
					<tr>
						<@columnData width="${precentToPixelConverter(25)}"
							divstyle="color:#0089B7; font-size:10pt; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:149px;" data="${name}" />
						<@columnData width="${precentToPixelConverter(20)}"
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" data="${label}" />
						<td width="${precentToPixelConverter(55)}" valign='top'>
							<br/>
						</td>
					</tr>
					<#list listdata as row>
						<#if row_index = 0>
							<#local styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#else>
							<#local styles_for_border= "${BLANK}">
						</#if>
						<#if row?? && (row?size>1)>
							<tr>
								<@columnData tdstyle="background:#EBEEF0; max-width:149px;${styles_for_border};" width="${precentToPixelConverter(25)}"
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${replaceWithConstant(row[0])!BLANK}" />
								<#if row_index = 0>
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px;" data="${row[1]}" />
								<#else>
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px;" data="${(row[1]?split(' '))[0]}" />
								</#if>

								<#if row?size=3>
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(55)}"
										divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:328px;" data="${row[2]}" />
								<#else>
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(55)}"
										divstyle="max-width:328px;" data="${HTML_SPACE}" />
								</#if>
							</tr>
						</#if>
					</#list>
					<tr>
						<td colspan="3" style="border-top: 1pt solid #B4C1C6;">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writePreapprovalsummary listdata>
	<#if listdata?has_content>
		<#local currency=expense.paCurrency >
		<#if currency?? && (currency?length>0)>
			<#local label = "${replaceWithConstant('Estimated')} (${currency})">
		<#else>
			<#local label = "">
		</#if>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="font-size:9pt; color:#404040; text-align:right; background:#FFFFFF;">
					<tr>
						<@columnData width="${precentToPixelConverter(30)}"
							divstyle="color:#0089B7; font-size:10pt; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:170px;" data="${getMessageProperty('expense.email.text.pre_approval_summary')}" />
						<@columnData width="${precentToPixelConverter(10)}"
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" data="${label}" />
						<@columnData width="${precentToPixelConverter(20)}"
							divstyle="text-align:right; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" data="${replaceWithConstant('Submitted')}" />
						<@columnData width="${precentToPixelConverter(40)}"
							divstyle="text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:119px;" data="${BLANK}" />
					</tr>
					<#list listdata as row>
						<#if row_index = 0>
							<#local styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#else>
							<#local styles_for_border= "${BLANK}">
						</#if>
						<#if row?? && (row?size>1)>
							<#if row[0]?matches('Adjustments')>
								<tr>
									<@columnData tdstyle="background:#EBEEF0; max-width:149px;${styles_for_border};" width="${precentToPixelConverter(25)}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${row[0]!BLANK}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px; color:#FF0000" data="${row[1]?split(' ')[0]}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px;" data="${BLANK}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
										divstyle="text-align:left;margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px;" data="${BLANK}" />
								</tr>
							<#else>
								<tr>
									<@columnData tdstyle="background:#EBEEF0; max-width:149px;${styles_for_border};" width="${precentToPixelConverter(25)}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:135px;" data="${row[0]!BLANK}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px;" data="${row[1]?split(' ')[0]}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
										divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px;" data="${row[2]?split(' ')[0]}" />
									<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(20)}"
										divstyle="text-align:left;margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; min-width:90px; max-width:119px;" data="${BLANK}" />
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

<#macro writePolicyCompliancewarning listdata>
	<#if listdata?has_content>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" style="font-size:9pt; color:#404040; text-align:left; background:#FFFFFF;">
					<tr>
						<td valign="top" colspan="2">
							<@divData style="color:#0089B7; font-size:10pt; font-weight:bold; text-align:left; margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif;" value="!! ${replaceWithConstant('Policy Issue')} !!" />
						</td>
					</tr>
					<#list listdata as row>
						<#if row_index = 0>
							<#local styles_for_border= "border-top: 1pt solid #B4C1C6;">
						<#else>
							<#local styles_for_border= "${BLANK}">
						</#if>
						<#if row?? && (row?size>1)>
							<tr>
								<@columnData tdstyle="background:#EBEEF0;${styles_for_border};" width="${precentToPixelConverter(25)}"
									divstyle="margin-left:5px; margin-right:5px; text-align:right; font-family:tahoma,arial,sans-serif; min-width:135px; max-width:149px;" data="${row[0]!BLANK}" />
								<@columnData tdstyle="${styles_for_border};" width="${precentToPixelConverter(75)}"
									divstyle="margin-left:5px; margin-right:5px; font-family:tahoma,arial,sans-serif; max-width:447px;" data="${row[1]!BLANK}" />
							</tr>
						</#if>
					</#list>
					<tr>
						<td colspan="2" style="border-top: 1pt solid #B4C1C6;">
							<@divData style="" value="${HTML_SPACE}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</#if>
</#macro>

<#macro writeSectionsDefault>
	<@writeExpenseRow expenserowdata=expense.expenserowdata!DUMMY_ARRAY />
	<@writeExpensepurpose name="${replaceWithConstant('Reason for Assignment')}" listdata=expense.reasonforassignment!DUMMY_ARRAY />
	<@writeCompliancewarning compliancewarning=expense.compliancewarning!DUMMY_ARRAY />
	<@writePolicyCompliancewarning listdata=expense.compliancewarning!DUMMY_ARRAY />
	<@writeNotes listdata=expense.expenseReportNotes!DUMMY_ARRAY />
	<@writeExpensepurpose name="${replaceWithConstant('Business Purpose')}" listdata=expense.businesspurpose!DUMMY_ARRAY />
	<@writeExpenseaccountsummary name="${replaceWithConstant('Account Summary')}" listdata=expense.accountsummary!DUMMY_ARRAY />
	<@writeSummaries name="${replaceWithConstant('Expense Summary')}" listdata=expense.expensesummary!DUMMY_ARRAY />
	<@writeUdadatadetail listdata=expense.udadatadetail!DUMMY_ARRAY />
	<@writeExpensedetails_ expensedetails_=expense.expensedetailsItems!DUMMY_ARRAY listdataComplianceWarnings=expense.complianceWarningItems!DUMMY_ARRAY listdataNotes=expense.itemnotesmultilevel!DUMMY_ARRAY  listdataReceipts=expense.lineItemImagesPageIndexeURLs!DUMMY_ARRAY />
	<@writeFinancialsummary listdata=expense.financialsummary!DUMMY_ARRAY />
</#macro>

<#macro writeReceiptLink link reportIdLabel reportId footer>
	<#if link?? && (link?length>1)>
		<tr>
			<td align="left" valign="top" colspan="1">
				<a href="${link}" style=color:#404040;  text-decoration:none; font-family:tahoma,arial,sans-serif;">
					<@spanData value=">> " />
					<@spanData style="color:#0089B7; text-decoration:underline; font-family:tahoma,arial,sans-serif;  -webkit-text-size-adjust:none;" value="${replaceWithConstant('View Receipts')}" />
				</a>
			</td>
			<#if reportId?? && (reportId?length>1)>
				<td align="right" valign="top" colspan="1">
					<@divData style="text-align:right; margin-left:5px; margin-right:5px; padding-bottom:2px; padding-top:2px; font-family:tahoma,arial,sans-serif;" value="${reportIdLabel}: ${reportId}" />
					<#if footer>
						<br/>
					</#if>
				</td>
			</#if>
		</tr>
	</#if>
</#macro>
