<#assign expense = model.data.emailData >
<#assign HTML_SPACE = "&nbsp;" >
<#assign BLANK = "" >
<#assign DUMMY_ARRAY = [] >
<#assign table_width = 596 >
<#assign header = true >
<#assign hasline = false >
<#assign accountsummary4items = [15, 30, 35, 20]>
<#assign accountsummary5items = [15, 5, 25, 35, 20]>
<#if !(commonPrefix??)  >
	<#assign commonPrefix = 'expense.email.'>
</#if>
<#assign keyPrefix = 'text.'>
<#assign itemTypePrefix = 'itemtype.'>
<#assign udaTypePrefix = 'uda.'>
<#assign udfTypePrefix = 'udf.'>

<#include "templates/EmailFormat_Expense_functions.ftl">

<html>
	<head>
		<meta http-equiv="content-type" content="text/html;charset=utf-8" />
		<style type='text/css'>
			#maintable {width:600px;}
				@media screen and (max-width: 660px){
				#maintable {width:100%; max-width:600px;}
				* {-webkit-text-size-adjust:none;}
				}
				
				<!--.tdcolumn{width: 149px;}-->
				<!--#tdcol{width: 149px;}-->
		</style>
	</head>
	<body background='#EBEEF0;'>
		<table cellpadding='0' cellspacing='0' width='100%' style='background:#EBEEF0;'>
			<tr>
				<td>
					<table id='maintable' cellpadding='0' cellspacing='0' align='center' style='border-collapse: collapse; font-family:tahoma,arial,sans-serif; color:#404040; max-width:600px;'>
						<@dataDIVRow />
						<@dataDIVRow />
						<tr>
							<td>
								<#-- Header with report id START -->
								<table cellpadding='0' cellspacing='0' width='100%' style='background:#EBEEF0; font-size:9pt; font-weight:normal; color:#404040;'>
									<#if expense.hasReportIdInHeader!false >
										<@writeID label="${replaceWithConstant('Report ID')}" value="${expense.reportId!BLANK}" />
									</#if>
									<#if expense.hasPreApprovalIdInHeader!false >
										<@writeID label="${replaceWithConstant('Pre-Approval ID')}" value="${expense.reportId!BLANK}" />
									</#if>
								</table>
								<#-- Header with report id END -->
								
								<#-- Report Container with Border START -->
								<table cellpadding='0' cellspacing='0' align='center' width='100%' style=' background:#FFFFFF; border-collapse: collapse; border: 2pt solid #B4C1C6;'>
									<@writeHeader value=expense.header!DUMMY_ARRAY />
									<#-- HeaderNotes Information -->
									<@writeHeaderEmailRow headerNotes=expense.headerNotes!DUMMY_ARRAY />
									<#-- Button101 Information -->
									<@writeButton101 button101=expense.button101!DUMMY_ARRAY />
									<#-- writeInforowswhichcontainsemails -->
									<@writeInforowswhichcontainsemails inforowswhichcontainsemails=expense.inforowswhichcontainsemails!DUMMY_ARRAY />
									<#-- writeInfoRow --> 
									<@writeInfoRowString value="${replaceWithConstant(expense.inforow!BLANK)}" value1="${replaceWithConstant(expense.compoundInforow!BLANK,'.')}"  />
									<#-- writeInfoRowPaidExpense -->
									<@writeInfoRowPaidExpense value="${expense.infoRowPaidExpense!BLANK}" value1="${replaceWithConstant(expense.compoundInforowPaidExpense!BLANK)}" />
									<#-- writeInfoRows -->
									<@writeInfoRowList values=expense.inforows!DUMMY_ARRAY />
									<#-- writeExpenseRow -->
									<@writeExpenseRow expenserowdata=expense.expenserowdata!DUMMY_ARRAY />
									<#-- writePACNotes -->
									<@writeexpensereportnotes w1=15 w2=25 w3=60 name="${replaceWithConstant('Notes')}" listdata=expense.pacnotes!DUMMY_ARRAY />
									<#-- writePACNoteskirkland -->
									<@writeexpensereportnotes w1=29 w2=29 w3=42 name="${replaceWithConstant('Notes')}" listdata=expense.pacnoteskirkland!DUMMY_ARRAY />
									<#-- writeUnsubmittedreports -->
									<@writeUnsubmittedreports unsubmittedreportsdata=expense.unsubmittedreports!DUMMY_ARRAY sub_names=expense.unsubmittedReportsSubNames!DUMMY_ARRAY />
									<#-- writeUnapproveditemsreminder -->
									<@writeUnapproveditemsreminder unapproveditemsreminderdata=expense.unapproveditemsreminder!DUMMY_ARRAY />
									<#-- writePaidExpenses -->
									<@writePaidExpenses1 paymentDateToPaidExpense=expense.paymentDateToPaidExpenses!DUMMY_ARRAY isSuppressEFTCheckNumber=expense.suppressEFTCheckNumber />
									<#-- writePreapprovalunapproveditems -->
									<@writePreapprovalunapproveditems preapprovalunapproveditems=expense.preapprovalunapproveditems!DUMMY_ARRAY />
									<#-- writeUnusedfirmpaiditemsinfo -->
									<@writeUnusedfirmpaiditemsinfo firmpaiditemsinfo=expense.unusedrirmpaiditemsinfo!DUMMY_ARRAY />
									<#-- writeUnusedfirmpaidreminderdays30 -->
									<@writeUnusedfirmpaidreminderdays30 unusedfirmpaidreminderdays30=expense.unusedfirmpaidreminderdays30!DUMMY_ARRAY sub_names_param=expense.unusedFirmpaidReminderSubNames!DUMMY_ARRAY />
									<#-- writeUnusedfirmpaidreminderdays31_60 -->
									<@writeUnusedfirmpaidreminderdays31_60 unusedfirmpaidreminderdays31_60=expense.unusedfirmpaidreminderdays31_60!DUMMY_ARRAY sub_names_param=expense.unusedFirmpaidReminderSubNames!DUMMY_ARRAY />
									<#-- writeUnusedfirmpaidreminderdays61_90 -->
									<@writeUnusedfirmpaidreminderdays61_90 unusedfirmpaidreminderdays61_90=expense.unusedfirmpaidreminderdays61_90!DUMMY_ARRAY sub_names_param=expense.unusedFirmpaidReminderSubNames!DUMMY_ARRAY />
									<#-- writeUnusedfirmpaidreminderdays90Plus -->
									<@writeUnusedfirmpaidreminderdays90Plus unusedfirmpaidreminderdays90Plus=expense.unusedfirmpaidreminderdays90Plus!DUMMY_ARRAY sub_names_param=expense.unusedFirmpaidReminderSubNames!DUMMY_ARRAY />
									<#-- writeUnusedtransactions -->
									<@writeUnusedtransactions unusedtransactions=expense.unusedtransactions!DUMMY_ARRAY />
									<#-- writeTotal -->
									<@writeTotal total=expense.total!DUMMY_ARRAY />
									<#-- writeInstructionshsr -->
									<@writeInstructionshsr instructionshsr=expense.instructionshsr!DUMMY_ARRAY />
									<#-- writeReportnotes -->
									<@writeExpensereportnotes w1=12 w2=20 w3=68 name="${replaceWithConstant('Report Notes')}" listdata=expense.reportnotes!DUMMY_ARRAY />
									<#-- writeReportnoteskirkland -->
									<@writeExpensereportnotes w1=25 w2=33 w3=42 name="${replaceWithConstant('Report Notes')}" listdata=expense.reportnoteskirkland!DUMMY_ARRAY />
									<#-- writeItemnotes -->
									<@writeExpensereportnotes w1=12 w2=20 w3=68 name="${replaceWithConstant('Item Notes')}" listdata=expense.itemnotes!DUMMY_ARRAY />
									<#-- writeExpenseLinesItemReturned -->
									<@writeExpenseLinesItemReturned listdata=expense.expenseLineItemsReturned!DUMMY_ARRAY />
									<#-- writeItemnoteskirkland -->
									<@writeExpensereportnotes w1=25 w2=33 w3=42 name="${replaceWithConstant('Item Notes')}" listdata=expense.itemnoteskirkland!DUMMY_ARRAY />
									<#-- writeItemdetails -->
									<@writeItemdetails itemdetails=expense.itemdetails!DUMMY_ARRAY />
									<#-- writeCompliancewarning -->
									<@writeCompliancewarning compliancewarning=expense.compliancewarning!DUMMY_ARRAY />
									<#-- writeExpensedetails_ -->
									<@writeExpensedetails_ expensedetails_=expense.expensedetails_!DUMMY_ARRAY />
									<#-- writeExpensedetails -->
									<@writeExpensedetails listdata=expense.expensedetails!DUMMY_ARRAY />
									<#-- writeReasonforassignment -->
									<@writeExpensepurpose name="${replaceWithConstant('Reason for Assignment')}" listdata=expense.reasonforassignment!DUMMY_ARRAY />
									<#-- writeRoutingDescription -->
									<@writeExpensepurpose name="${replaceWithConstant('Rule Description')}" listdata=expense.routingDescriptions!DUMMY_ARRAY />
									<#-- writeBusinesspurpose -->
									<@writeExpensepurpose name="${replaceWithConstant('Business Purpose')}" listdata=expense.businesspurpose!DUMMY_ARRAY />
									<#-- writeAllocation -->
									<@writeExpenseaccountsummary name="${replaceWithConstant('Allocation')}" listdata=expense.allocation!DUMMY_ARRAY />
									<#-- writeCmattersummary -->
									<@writeExpenseaccountsummary name="${replaceWithConstant('Client/Matter Summary')}" listdata=expense.cmattersummary!DUMMY_ARRAY />
									<#-- writeNCmattersummary -->
									<@writeSummaries name="${replaceWithConstant('Non-Client/Matter Summary')}" listdata=expense.ncmattersummary!DUMMY_ARRAY />
									<#-- writeTCANCexpensesummary -->
									<@writeSummaries name="${replaceWithConstant('Total Client and Non-Client Expense Summary')}" listdata=expense.tcancexpensesummary!DUMMY_ARRAY /> 
									<#-- writeExpenseitems -->
									<@writeExpenseitems listdata=expense.expenseitems!DUMMY_ARRAY />
									<#-- writeGrandtotal -->
									<@writeGrandtotal data=expense.grandtotal!BLANK grandTotalLabel=expense.grandtotalLabel!"Grand Total" grandTotalAlignment=expense.grandtotalAlignment!"left"/>
									<#-- writeTotalReimbursements -->
									<@writeTotalReimbursements data=expense.totalReimbursements!BLANK totalReimbursementsLabel=expense.totalReimbursementsLabel!"Total Reimbursements" totalReimbursementsAlignment=expense.totalReimbursementsAlignment!"left"/>
									<#-- writeTotalCompanyPaid -->
									<@writeTotalCompanyPaid data=expense.totalCompanyPaid!BLANK totalCompanyPaidLabel=expense.totalCompanyPaidLabel!"Total Company Paid" totalCompanyPaidAlignment=expense.totalCompanyPaidAlignment!"left"/>
									<#-- writeDescription -->
									<@writeExpensepurpose name="${replaceWithConstant('Internal Guests')}" listdata=expense.description!DUMMY_ARRAY />
									<#-- writeInternalguests -->
									<@writeExpensepurpose name="${replaceWithConstant('Internal Guests')}" listdata=expense.internalguests!DUMMY_ARRAY />
									<#-- writeExternalguests -->
									<@writeExpensereportnotes w1=33 w2=33 w3=34 name="${replaceWithConstant('External Guests')}" listdata=expense.externalguests!DUMMY_ARRAY />
									<#-- writeReportnotes109 -->
									<@writeExpensereportnotes w1=15 w2=25 w3=60 name="${replaceWithConstant('Report Notes')}" listdata=expense.reportnotes109!DUMMY_ARRAY />
									<#-- writeItemnotes109 -->
									<@writeExpensereportnotes w1=15 w2=25 w3=60 name="${replaceWithConstant('Item Notes')}" listdata=expense.itemnotes109!DUMMY_ARRAY />
									<#-- writeAccountsummary -->
									<@writeExpenseaccountsummary name="${replaceWithConstant('Account Summary')}" listdata=expense.accountsummary!DUMMY_ARRAY />
									<#-- writeAccountsummary84 -->
									<@writeAccountsummary84 listdata=expense.accountsummary84!DUMMY_ARRAY />
									<#-- writeInstructions -->
									<@writeExpensepurpose name="${replaceWithConstant('Instructions')}" listdata=expense.instructions!DUMMY_ARRAY />
									<#-- writeExpensesummary -->
									<@writeSummaries name="${replaceWithConstant('Expense Summary')}" listdata=expense.expensesummary!DUMMY_ARRAY />
									<#-- writeBusinesspurpose104 -->
									<@writeBusinesspurpose104 listdata=expense.businesspurpose104!DUMMY_ARRAY />
									<#-- writeUdadatadetail -->
									<@writeUdadatadetail listdata=expense.udadatadetail!DUMMY_ARRAY />
									<#-- writeAddtlnotes -->
									<@writeAddtlnotes listdata=expense.addtlnotes!DUMMY_ARRAY />
									<#-- writeExpensetransactions -->
									<@writeExpensetransactions listdata=expense.expensetransactions!DUMMY_ARRAY />
									<#-- writeFinancialsummary -->
									<@writeFinancialsummary listdata=expense.financialsummary!DUMMY_ARRAY />
									<#-- writeUnapprovedInvoicesReminder -->
									<@writeUnapprovedInvoicesReminder listdata=expense.unapprovedInvoicesReminder!DUMMY_ARRAY />
									<#-- writeButton -->
									<@writeButton button=expense.button!DUMMY_ARRAY />
									<#-- writePAButton -->
									<@writePAButton listdata=expense.pabutton!DUMMY_ARRAY />
									<#-- writeBottompage -->
									<@writeBottompage />
								</table>
								<#-- Report Container with Border END -->
								
								<#-- Footer START -->
								<table cellpadding='0' cellspacing='0' width='100%' style='background:#EBEEF0; font-size:9pt; font-weight:normal; color:#404040;'>
									<#if expense.hasReportId!false >
										<@writeID label="${replaceWithConstant('Report ID')}" value="${expense.reportId!BLANK}" />
									</#if>
									<#if expense.hasPreApprovalIdInHeader!false >
										<@writeID label="${replaceWithConstant('Pre-Approval ID')}" value="${expense.reportId!BLANK}" />
									</#if>
									<#if !expense.hasPACustomInstructions!false >
										<@writeInstructioninbottom args=expense.infourls!DUMMY_ARRAY />
									</#if>
									<#if expense.instructionsUrl.url?has_content >
										<@writeInstructionsUrl Instructions_URL=expense.instructionsUrl.url!BLANK instructionsText=expense.instructionsUrl.instructionsText!BLANK/>
									</#if>
									<#-- writeEmailrow -->
									<@writeEmailrow listdata=expense.notes!DUMMY_ARRAY />
									<#-- writeCombinedemailrows -->
									<@writeCombinedemailrows listdata=expense.combinedemailrows!DUMMY_ARRAY />
								</table>
								<#-- Footer END -->
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<@dataDIVRow />
			<@dataDIVRow />
		</table>
	</body>
</html>