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

<#macro tables title="" rightHeader="" rows="" footer="">
	<table style='width: 100%; border-collapse: collapse;'>
		<tbody>
			<tr>
				<#if rightHeader?has_content>
					<td style='font-weight: 600; padding-bottom: 7px;'>
						${title}
					</td>
					<td style='text-align: right; padding-bottom: 7px;'>
						Amount (${rightHeader})
					</td>
				<#else>
					<td colspan='${rows?first?size}' style='font-weight: 600; padding-bottom: 7px;'>
						${title}
					</td>
				</#if>
			</tr>
			<#if rows?has_content>
				<#list rows as row>
					<tr>
						<#list row?values as value>
							<#if value?counter == row?size>
								<td style='text-align: right; padding: 7px 0; border-top: 1px solid #e7e9ea; border-bottom: 1px solid #e7e9ea;'>
							<#else>
								<td style='padding: 7px 0; border-top: 1px solid #e7e9ea; border-bottom: 1px solid #e7e9ea;'>
							</#if>
								<#if value?is_string>
									${value}
								<#else>
									<#if value?is_hash>
										<#list value?values as subValue>
											${subValue}<#if subValue?counter != value?size><br/></#if>
										</#list>
									<#else>
										<#list value as subValue>
											${subValue}<#if subValue?counter != value?size><br/></#if>
										</#list>
									</#if>
								</#if>
							</td>
						</#list>
					</tr>
				</#list>
			</#if>
			<#if footer?has_content>
				<#list footer as row>
					<tr>
						<#list row?values as value>
							<td style='text-align: right; padding: 7px 0; font-weight: 600; border-top: 1px solid #e7e9ea; '>
								${value}
							</td>
						</#list>
					</tr>
				</#list>
			</#if>
		</tbody>
	</table>
</#macro>

<#macro commentTable rows >
	<table style='width: 100%; border-collapse: collapse;'>
		<tbody>
			<tr>
				<td colspan='2' style='font-weight: 600; padding-bottom: 7px;'>
					Comments
				</td>
			</tr>
			<#if rows?has_content>
				<#list rows as row>
					<tr>
						<td style='padding: 7px 0 0; border-top: 1px solid #e7e9ea;' class='mobile_td_full-width'>
							${row.user}
						</td>
						<td style='text-align: right; padding: 7px 0 0; border-top: 1px solid #e7e9ea;' class='mobile_td_full-width mobile_remove-border'>
							${row.date}
						</td>
					</tr>
					<tr>
						<td colspan='2' style='padding: 0 0 7px; border-bottom: 1px solid #e7e9ea;' class='mobile_td_full-width'>
							<#list row.comments as comment>
								${comment}<br/>
							</#list>
						</td>
					</tr>
				</#list>
			</#if>
		</tbody>
	</table>
</#macro>

<#macro accountSummaryTable title rows currency totals>
	<table class='accountSummaryTable' style='width: 100%; border-collapse: collapse;'>
		<tbody>
			<tr>
				<td colspan='3' style='font-weight: 600; padding-bottom: 7px;'>
					${title}
				</td>
				<td style='text-align: right; padding-bottom: 7px;'>
					Amount (${currency})
				</td>
			</tr>
			<#if rows?has_content>
				<#list rows as row>
					<tr style='font-size: 13px;'>
						<td valign="top" style='padding: 7px 10px 7px 0; border-top: 1px solid #e7e9ea; min-width: 90px;'>
							${row.MOSID}
						</td>
						<td valign="top" style='padding: 7px 0; border-top: 1px solid #e7e9ea;'>
							${row.Name}<br/>
							<span style='display: none; color: #9fa4a6;' class="mobile_span-show">
								${row.Description}
							</span>
						</td>
						<td valign="top" class='mobile_remove-border' style='color: #9fa4a6; padding: 7px 0; border-top: 1px solid #e7e9ea;'>
							<span class='mobile_hidden'>${row.Description}</span>
						</td>
						<td valign="top" style='text-align: right; padding: 7px 0; border-top: 1px solid #e7e9ea;'>
							${row.amount}
						</td>
					</tr>
					<#if row.MOSChildren?has_content>
					<#list row.MOSChildren as children>
					<tr style='font-size: 13px;'>
						<td></td>
						<td>
							<span style='display: none;' class="mobile_span-show">
								${children}
							</span>
						</td>
						<td valign="top" class='mobile_remove-border' style='padding: 1px 0;'>
							<span class='mobile_hidden'>${children}</span>
						</td>
						<td></td>
					</tr>
					</#list>
					</#if>
				</#list>
			</#if>
			<tr>
				<td colspan='4'>
					<@expenseTotalFooter subtotal=totals.Subtotal total=totals.Total />
				</td>
			</tr>
		</tbody>
	</table>
</#macro>

<#macro expenseSummaryTable title rows currency totals>
	<table style='width: 100%; border-collapse: collapse;'>
		<tbody>
			<tr>
				<td colspan='2' style='font-weight: 600; padding-bottom: 7px;'>
					${title}
				</td>
				<td style='text-align: right; padding-bottom: 7px;'>
					Amount (${currency})
				</td>
			</tr>
			<#if rows?has_content>
				<#list rows as row>
					<tr>
						<#list row?values as value>
							<#if value?counter == row?size>
								<td colspan='2' style='text-align: right; padding: 7px 0; border-top: 1px solid #e7e9ea;'>
							<#else>
								<td style='padding: 7px 0; border-top: 1px solid #e7e9ea;'>
							</#if>
								${value}
							</td>
						</#list>
					</tr>
				</#list>
			</#if>
			<tr>
				<td colspan='3'>
					<@expenseTotalFooter subtotal=totals.subtotal total=totals.total recieptURL='a5'/>
				</td>
			</tr>
		</tbody>
	</table>
</#macro>

<#macro guestDetailsTable rows>
	<table style='width: 100%; border-collapse: collapse;'>
		<tbody>
			<tr>
				<td colspan='2' style='font-weight: 600; padding-bottom: 7px;'>
					Guest Details
				</td>
			</tr>
			<#if rows?has_content>
				<#list rows as row>
					<tr>
						<td style='padding: 7px 0; border-top: 1px solid #e7e9ea; border-bottom: 1px solid #e7e9ea;'>
							${row.Name}<br/>
							<span style='display: none; color: #9fa4a6;' class="mobile_span-show">
								${row.Description}
							</span>
						</td>
						<td class='mobile_remove-border' style='padding: 7px 0; border-top: 1px solid #e7e9ea; border-bottom: 1px solid #e7e9ea;'>
							<span class='mobile_hidden'>${row.Description}</span>
						</td>
						<td style='text-align: right; padding: 7px 0; border-top: 1px solid #e7e9ea; border-bottom: 1px solid #e7e9ea;'>
							${row.Company}<br/>
						</td>
					</tr>
				</#list>
			</#if>
		</tbody>
	</table>
</#macro>

<#macro buttonsTable>
	<table class='btnTable' width='100%' style='width: 100%; border-collapse: collapse;'>
		<tbody>
			<tr>
				<td class='btnTable_td btnTable_view' style='padding: 20px 5px;'>
					<table><tbody><tr>
						<td style='border: none; background: #31b4cb; font-size: 14px; text-align: center; padding: 12px 20px; border-radius: 2px; font-weight: 500;'>
							<a href='#a2' style='color: #FFFFFF; text-decoration: none;'>View Full Report</a>
						</td>
					</tr></tbody></table>
				</td>
				<td class='btnTable_td btnTable_return' width='92px' style='padding: 20px 5px; text-align: right;'>
					<table><tbody><tr>
						<td style='border: none; background: #cf261a; font-size: 14px; text-align: center; padding: 12px 20px; border-radius: 2px; font-weight: 500;'>
							<a href='#a3' style='color: #FFFFFF; text-decoration: none;'>Return</a>
						</td>
					</tr></tbody></table>
				</td>
				<td class='btnTable_td btnTable_approve' width='102px' style='padding: 20px 5px; text-align: right;'>
					<table><tbody><tr>
						<td style='border: none; background: #86b53b; font-size: 14px; text-align: center; padding: 12px 20px; border-radius: 2px; font-weight: 500;'>
							<a href='#a2' style='color: #FFFFFF; text-decoration: none;'>Approve</a>
						</td>
					</tr></tbody></table>
				</td>
			</tr>
		</tbody>
	</table>
</#macro>

<#macro expenseDetailsTable expenseDetails currency recieptURL>
	<table style='width: 100%; border-collapse: collapse;'>
		<tbody valign='top'>
			<tr>
				<td colspan='3' style='font-weight: 600; padding-bottom: 7px;'>
					Expense Details
				</td>
				<td colspan='2' style='text-align: right; padding-bottom: 7px;'>
					Amount (${currency})
				</td>
			</tr>
			<#list expenseDetails.lineItems as row>
				<@expenseDetailsTableRow row=row isChild=false />
			</#list>
			<tr><td colspan='5' style='padding: 10px;'></td></tr>
			<tr>
				<td colspan='5'>
					<@expenseTotalFooter total=expenseDetails.total subtotal=expenseDetails.subtotal recieptURL=recieptURL />
				</td>
			</tr>
		</tbody>
	</table>
</#macro>

<#macro expenseDetailsTableRow row isChild>
	<tr>
		<#if isChild>
		<td style='padding: 7px 10px 0 10px; border-top: 10px solid #FFF; border-left: 8px solid #f5f8fa; min-width: 66px;'>
		<#else>
		<td style='padding: 7px 10px 0px 0; border-top: 1px solid #e7e9ea; min-width: 80px;'>
		</#if>
			<span style='font-weight: 600;'>${row.icon}</span><br/>
			<span style='font-weight: 500; font-size: 10px;'>${row.date}</span><br/>
			<a href='${row.recieptUrl}' style='font-size: 10px; color: #31b4cb;'>Reciept</a>
		</td>
		<#if isChild>
		<td colspan='3' style='padding: 7px 10px 0 0px; border-top: 10px solid #FFF;'>
		<#else>
		<td colspan='3' style='padding: 7px 10px 0px 0; border-top: 1px solid #e7e9ea;'>
		</#if>
			<span>${row.title}</span>
			<span style='font-size: 11px; line-height: 11px;'>
			<#if row.businessPurpose?has_content>
				<br/>${row.businessPurpose}
			</#if>
			<#if row.businessDescription?has_content>
				<br/>${row.businessDescription}
			</#if>
			</span>
		</td>
		<#if isChild>
		<td style='padding: 7px 0px 0 0; text-align: right; font-weight: 600; border-top: 10px solid #FFF;'>
		<#else>
		<td style='padding: 7px 0px 0px 0; border-top: 1px solid #e7e9ea; text-align: right; font-weight: 600;'>
		</#if>
			${row.amount}<br/>
			<#if row.originalAmount?has_content>
				<span style='font-weight: 400; font-size: 10px;'>(${row.originalAmount} ${row.originalCurrency})</span>
			</#if>
		</td>
	<#if row.details?has_content>
	<tr>
		<#if isChild>
		<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
			<span style='display: none;' class='mobile_span-show'>
				Details
			</span>
		</td>
		<#else>
		<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
			<span style='display: none;' class='mobile_span-show'>
				Details
			</span>
		</td>
		</#if>
		<td class='mobile_remove-border' style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
			<span class='mobile_hidden'>Details</span>
		</td>
		<td colspan='3' style='padding: 5px 0; font-size: 12px; font-weight: 500;'>
			${row.details}
		</td>
	</tr>
	</#if>
	<#if row.guests?has_content>
	<tr>
		<#if isChild>
		<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
			<span style='display: none;' class='mobile_span-show'>
				People
			</span>
		</td>
		<#else>
		<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
			<span style='display: none;' class='mobile_span-show'>
				People
			</span>
		</td>
		</#if>
		<td class='mobile_remove-border' style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
			<span class='mobile_hidden'>People</span>
		</td>
		<td colspan='3' style='padding: 5px 0; font-size: 12px; font-weight: 500;'>${row.guests?size}</td>
	</tr>
	<#list row.guests as guest>
		<tr>
			<#if isChild>
			<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				<span style='display: none;' class='mobile_span-show'>
					Guest ${guest?counter}
				</span>
			</td>
			<#else>
			<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				<span style='display: none;' class='mobile_span-show'>
					Guest ${guest?counter}
				</span>
			</td>
			</#if>
			<td class='mobile_remove-border' style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				<span class='mobile_hidden'>Guest ${guest?counter}</span>
			</td>
			<td colspan='2' style='padding: 5px 0; font-size: 12px; font-weight: 500;'>${guest.name} ${guest.company}</td>
			<td style='padding: 5px 0; font-size: 12px; font-weight: 500; text-align: right;'>${guest.amount}</td>
		</tr>
		<#if guest?counter==10>
			<tr>
				<#if isChild>
				<td style='border-left: 8px solid #f5f8fa;'></td>
				<#else>
				<td></td>
				</#if>
				<td></td>
				<td colspan='4' style='padding: 0px 0px 5px;'>
					<a href='a0' style='font-size: 10px; color: #31b4cb'>View full reports for all guests</a>
				</td>
			</tr>
			<#break>
		</#if>
	</#list>
	</#if>
	<#if row.perDiem?has_content>
	<#list row.perDiem as perDiem>
		<tr>
			<#if perDiem?counter == 1>
				<#if isChild>
				<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span style='display: none;' class='mobile_span-show'>
						Per Diem
					</span>
				</td>
				<#else>
				<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span style='display: none;' class='mobile_span-show'>
						Per Diem
					</span>
				</td>
				</#if>
			<#else>
				<#if isChild>
				<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				</td>
				<#else>
				<td>
				</td>
				</#if>
			</#if>
			<#if perDiem?counter == 1>
				<td class='mobile_remove-border' style='padding: 5px 8px 0px 0px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span class='mobile_hidden'>Per Diem</span>
				</td>
				<td colspan='2' style='padding: 5px 0px 0px; font-size: 12px; font-weight: 500;'>
					${perDiem.name}
				</td>
				<#if perDiem.personal>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500; color: #cf261a;'>
				<#else>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500;'>
				</#if>
					${perDiem.amount}
				</td>
			<#else>
				<td></td>
				<td colspan='2' style='font-size: 12px; font-weight: 500;'>
					${perDiem.name}
				</td>
				<#if perDiem.personal>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500; color: #cf261a;'>
				<#else>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500;'>
				</#if>
					${perDiem.amount}
				</td>
			</#if>
		</tr>
	</#list>
	</#if>
	<#if row.personalItems?has_content>
	<#list row.personalItems as personalItem>
		<tr>
			<#if isChild>
			<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				<span style='display: none;' class='mobile_span-show'>
					Personal Item
				</span>
			</td>
			<#else>
			<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				<span style='display: none;' class='mobile_span-show'>
					Personal Item
				</span>
			</td>
			</#if>
			<#if personalItem?counter == 1>
				<td class='mobile_remove-border' style='padding: 5px 8px 0px 0px; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
					<span class='mobile_hidden'>Personal Item</span>
				</td>
				<td colspan='2' style='padding: 5px 0px 0px; font-size: 12px; font-weight: 500;'>
					${personalItem.name}
				</td>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500; color: #cf261a;'>
					${personalItem.amount}
				</td>
			<#else>
				<td></td>
				<td colspan='2' style='font-size: 12px; font-weight: 500;'>
					${personalItem.name}
				</td>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500; color: #cf261a;'>
					${personalItem.amount}
				</td>
			</#if>
		</tr>
	</#list>
	</#if>
	<#if row.firmPaidItems?has_content>
	<#list row.firmPaidItems as firmPaidItem>
		<tr>
			<#if isChild>
			<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				<span style='display: none;' class='mobile_span-show'>
					Firm Paid Item
				</span>
			</td>
			<#else>
			<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				<span style='display: none;' class='mobile_span-show'>
					Firm Paid Item
				</span>
			</td>
			</#if>
			<#if firmPaidItem?counter == 1>
				<td class='mobile_remove-border' style='padding: 5px 8px 0px 0px; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
					<span class='mobile_hidden'>Firm Paid Item</span>
				</td>
				<td colspan='2' style='padding: 5px 0px 0px; font-size: 12px; font-weight: 500;'>
					${firmPaidItem.name}
				</td>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500;'>
					${firmPaidItem.amount}
				</td>
			<#else>
				<td></td>
				<td colspan='2' style='font-size: 12px; font-weight: 500;'>
					${firmPaidItem.name}
				</td>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500;'>
					${firmPaidItem.amount}
				</td>
			</#if>
		</tr>
	</#list>
	</#if>
	<#if row.extras?has_content>
		<#list row.extras as extraData>
			<tr>
				<#if isChild>
				<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span style='display: none;' class='mobile_span-show'>
						${extraData.label}
					</span>
				</td>
				<#else>
				<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span style='display: none;' class='mobile_span-show'>
						${extraData.label}
					</span>
				</td>
				</#if>
				<td class='mobile_remove-border' style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
					<span class='mobile_hidden'>${extraData.label}</span>
				</td>
				<td colspan='2' style='padding: 5px 0; font-size: 12px; font-weight: 500;'>
					${extraData.value}
				</td>
				<td style='padding: 5px 0; font-size: 12px; font-weight: 500; text-align: right;'>
					${extraData.amount}
				</td>
			</tr>
		</#list>
	</#if>
	<#if row.misc?has_content>
	<tr>
		<#if isChild>
		<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
			<span style='display: none;' class='mobile_span-show'>
				Misc
			</span>
		</td>
		<#else>
		<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
			<span style='display: none;' class='mobile_span-show'>
				Misc
			</span>
		</td>
		</#if>
		<td class='mobile_remove-border' style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
			<span class='mobile_hidden'>Misc</span>
		</td>
		<td colspan='3' style='padding: 5px 0; font-size: 12px; font-weight: 500;'>
			${row.misc}
		</td>
	</tr>
	</#if>
	<#if row.vat?has_content>
		<#list row.vat as vat>
		<tr>
			<#if vat?counter == 1>
				<#if isChild>
				<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span style='display: none;' class='mobile_span-show'>
						VAT
					</span>
				</td>
				<#else>
				<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span style='display: none;' class='mobile_span-show'>
						VAT
					</span>
				</td>
				</#if>
				<td width='77px' class='mobile_td-hidden mobile_remove-border' style='padding: 5px 8px 0px 0px; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
					<span class='mobile_hidden'>VAT</span>
				</td>
			<#else>
				<#if isChild>
					<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'></td>
				<#else>
					<td></td>
				</#if>
				<td></td>
			</#if>
			<td style='font-size: 12px; font-weight: 500;'>
				${vat.code}
			</td>
			<td colspan='1' style='font-size: 12px; font-weight: 500;'>
				${vat.percent}
			</td>
			<td style='font-size: 12px; font-weight: 500; text-align: right;'>
				${vat.value}
			</td>
		</tr>
		</#list>
	</#if>
	<#if row.allocations?has_content>
		<#list row.allocations as allocation>
		<tr>
			<#if allocation?counter == 1>
				<#if isChild>
				<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span style='display: none;' class='mobile_span-show'>
						Allocation
					</span>
				</td>
				<#else>
				<td class='mobile_td-hidden' style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
					<span style='display: none;' class='mobile_span-show'>
						Allocation
					</span>
				</td>
				</#if>
				<td width='77px' class='mobile_td-hidden mobile_remove-border' style='padding: 5px 8px 0px 0px; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
					<span class='mobile_hidden'>Allocation</span>
				</td>
				<td style='padding: 5px 0px 0px; font-size: 12px; font-weight: 500;'>
					${allocation.id}
				</td>
				<td style='padding: 5px 0px 0px; font-size: 12px; font-weight: 500;'>
					${allocation.name}
				</td>
				<td style='padding: 5px 0px 0px; text-align: right; font-size: 12px; font-weight: 500;'>
					${allocation.amount}
				</td>
			<#else>
				<#if isChild>
					<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'></td>
				<#else>
					<td></td>
				</#if>
				<td></td>
				<td style='font-size: 12px; font-weight: 500;'>
					${allocation.id}
				</td>
				<td style='font-size: 12px; font-weight: 500;'>
					${allocation.name}
				</td>
				<td style='text-align: right; font-size: 12px; font-weight: 500;'>
					${allocation.amount}
				</td>
			</#if>
		</tr>
		<#if allocation.onSelect?has_content>
			<#list allocation.onSelect as onSelect>
					<tr>
						<td></td>
						<td></td>
						<td colspan='3' style='font-size: 12px; font-weight: 500;'>${onSelect}</td>
					</tr>
			</#list>
		</#if>
		<#if allocation.vats?has_content>
			<#list allocation.vats as vat>
				<tr>
					<#if isChild>
					<td style='border-left: 8px solid #f5f8fa;'></td>
					<#else>
					<td></td>
					</#if>
					<td></td>
					<td style='color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
						${vat.type}
					</td>
					<td style='text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
						${vat.label}
					</td>
					<td style='text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px; text-align: right;'>
						${vat.value}
					</td>
				</tr>
			</#list>
		</#if>
		</#list>
	</#if>
	<#if row.comments?has_content>
		<#list row.comments as comment>
		<tr>
			<#if isChild>
			<td style='border-left: 8px solid #f5f8fa; padding: 5px 8px 5px 10px; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'></td>
			<#else>
			<td style='padding: 5px 8px 5px 0; color: #9fa4a6; text-transform: uppercase; font-size: 10px; font-weight: 500; line-height: 14px;'>
				<span style='display: none;' class='mobile_span-show'>
					Comments
				</span>
			</td>
			</#if>
			<td class='mobile_remove-border' style='padding: 5px 8px 0px 0px; color: #9fa4a6; text-transform: uppercase; font-size: 11px; font-weight: 500; line-height: 14px;'>
				<span class='mobile_hidden'>Comments</span>
			</td>
			<td colspan='2' style='padding: 5px 0 0; font-size: 12px; font-weight: 500;'>${comment.user}</td>
			<td style='padding: 5px 0 0; font-size: 12px; font-weight: 500; text-align: right;'>${comment.date}</td>
		</tr>
		<tr>
			<#if isChild>
			<td colspan='2' style='border-left: 8px solid #f5f8fa'></td>
			<#else>
			<td colspan='2'></td>
			</#if>
			<td colspan='3' style='font-size: 12px; font-weight: 500;'>${comment.comment}</td>
		</tr>
		</#list>
	</#if>
	<#if row.compliance?has_content>
		<#list row.compliance as complianceWarning>
			<tr>
				<td colspan='5' style='padding: 10px;' >
					<@complianceTable warningCode=complianceWarning.warningCode warningTitle=complianceWarning.warningTitle response=complianceWarning.response />
				</td>
			</tr>
		</#list>
	</#if>
	<#if row.children?has_content>
		<#list row.children as child>
			<@expenseDetailsTableRow row=child isChild=true />
		</#list>
	</#if>
	<tr>
		<td colspan='' style='padding: 5px;'></td>
	</tr>
</#macro>

<#macro complianceTable warningCode="" warningTitle="" response="">
	<table style='background: #fceedb; width: 100%; border-radius: 5px; padding: 5px 10px; font-size: 11px; font-weight: 400;'>
		<tbody>
			<tr>
				<td colspan='2' style='color: #f0ad4e; font-weight: 600; padding: 0px 0px 5px; font-size: 12px;'>
					>> ${warningCode}: ${warningTitle}
				</td>
			</tr>
			<tr>
				<td width='82px' style='text-transform: uppercase; color: #9fa4a6; padding: 0px 10px 0px 0px;'>Response</td>
				<td style='color: #475156;'>${response}
			</tr>
		</tbody>
	</table>
</#macro>

<#macro expenseTotalFooter subtotal="" total="" recieptURL="">
	<table width='100%'>
		<tr class='mobile_tr-show' style='display: none;'>
			<td colspan='4' style='border-top: 1px solid #e7e9ea; padding-top: 10px;'>
				<#if recieptURL?has_content>
					<div style='width: 100%; display: inline-block; text-align: left; padding: 7px 0;'>
						<a href='${recieptURL}' style='color: #31b4cb;'>View all Receipts</a>
					</div>
				</#if>
				<#if subtotal?has_content>
				<div style='width: calc(50% - 2px); display: inline-block; text-align: right; padding: 7px 0; font-weight: 600;'>
					Subtotal
				</div>
				<div style='width: calc(50% - 2px); display: inline-block; text-align: right; padding: 7px 0; font-weight: 600;'>
					${subtotal}
				</div>
				</#if>
				<#if total?has_content>
				<div style='width: calc(50% - 2px); display: inline-block; text-align: right; padding: 7px 0; font-weight: 600;'>
					Total
				</div>
				<div style='width: calc(50% - 2px); display: inline-block; text-align: right; padding: 7px 0; font-weight: 500; font-size: 20px;'>
					${total}
				</div>
				</#if>
			</td>
		</tr>
		<#if subtotal?has_content>
		<tr class='mobile_hidden'>
			<#if recieptURL?has_content>
				<td style='text-align: left; padding: 7px 0; border-top: 1px solid #e7e9ea;'>
					<a href='${recieptURL}' style='color: #31b4cb;'>View all Receipts</a>
				</td>
				<td colspan='2' style='text-align: right; padding: 7px 0; font-weight: 600; border-top: 1px solid #e7e9ea;'>
					Subtotal
				</td>
			<#else>
				<td></td>
				<td></td>
				<td colspan='' style='text-align: right; padding: 7px 0; font-weight: 600; border-top: 1px solid #e7e9ea;'>
					Subtotal
				</td>
			</#if>
			<td style='text-align: right; padding: 7px 0; font-weight: 600; border-top: 1px solid #e7e9ea;'>
				${subtotal}
			</td>
		</tr>
		</#if>
		<#if total?has_content>
		<tr class='mobile_hidden'>
			<td colspan='3' style='text-align: right; padding: 7px 0; font-weight: 600;'>
				Total
			</td>
			<td style='text-align: right; padding: 7px 0; font-weight: 500; font-size: 20px;'>
				${total}
			</td>
		</tr>
		</#if>
	</table>
</#macro>
