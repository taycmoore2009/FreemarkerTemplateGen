<#assign expense = model.data.emailData >
<#assign HTML_SPACE = "&nbsp;" >
<#assign BLANK = "" >
<#assign DUMMY_ARRAY = [] >
<#assign table_width = 596 >
<#assign header = true >
<#assign hasbottompage = false >
<#assign hasline = false >
<#assign topinfo = false >
<#assign accountsummary4items = [15, 30, 35, 20]>
<#assign accountsummary5items = [15, 5, 25, 35, 20]>
<#assign commonPrefix = 'expense.email.'>
<#assign keyPrefix = 'text.'>
<#assign itemTypePrefix = 'itemtype.'>
<#assign udaTypePrefix = 'uda.'>
<#assign udfTypePrefix = 'udf.'>

<#include "templates/EmailFormat_ExpApprovalDefault_functions.ftl">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<meta name="description" content="About Us Chrome River was formed with the simple but powerful idea that a new approach could be taken for expense and invoice process automation. Using new technologies, we decided that the users view should drive the design and then simply allow the power of the platform to automate and control the process for the business. Wide adoption with limited training was becoming the new mantra of the internet and there was no reason that this should not apply to business applications as well. To deliver on this vision, the Chrome River team has brought together an ideal combination of experience, innovation and customer care which enables us to design, build, implement and support highly effective solutions for financial workflow automation processes. Our Experience	Collectively, Chrome River has over 100 years of experience serving the financial and practice management needs of organizations worldwide. With respect to expense control and efficient processing, we have a deep understanding of an organizations financial operations, processes and goals. Our solutions and services are designed from the ground up to uniquely offer the flexibility to fit our customers requirements. Our Customer Care Delivering the highest standard of customer care is a key component of our business at Chrome River, after all, we do provide software as a service.  Beginning with our consultative, best practices guidance, then delivering a full-featured turn-key solution, and ultimately supporting your companys team with quality care, Chrome Rivers experienced staff is there to guide and assist you every step of the way." />
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<style type='text/css'>#maintable {width:600px;}@media screen and (max-width: 660px){#maintable{width:100%; max-width:600px;}<!--.tdcolumn{width: 149px;}--><!--#tdcol{width: 149px;}-->
	</style>
	
	<body style="background:#475156;">
		<table cellpadding="0" cellspacing="0" width="100%" style="background:#475156;">
			<tr>
				<td>
					<#-- Report and Footer Wrapper -->
					<table id="maintable" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse; font-family:tahoma,arial,sans-serif; color:#404040; max-width:600px;">
						<tr>
							<td>
								<#-- Header with report id -->
								<table cellpadding="0" cellspacing="0" width="100%" style="margin-top: 50px; padding: 8px 0; background:#475156; font-size:9pt; font-weight:normal; color:#9FA4AC;">
									<tr>
										<td height="15" width="100%">
											<span> ${HTML_SPACE} </span>
										</td>
									</tr>
									<#if expense.hasReportIdInHeader!false >
										<@writeID label="${replaceWithConstant('Report ID')}" value="${expense.reportId!BLANK}" />
									</#if>
									<#if expense.hasPreApprovalIdInHeader!false >
										<@writeID label="${replaceWithConstant('Pre-Approval ID')}" value="${expense.reportId!BLANK}" />
									</#if>
								</table>
								<#-- End Header with report id -->
								<#-- Report Container with Border -->
								<table cellpadding="0" cellspacing="0" align="center" width="100%" style="background:#FFFFFF; border-collapse: collapse; border-width: 0px;  border-radius: 5px 5px 0 0;">
									<@writeHeader value=expense.header!DUMMY_ARRAY />
									<#assign hasline=false>
									<#if expense.instructionTop??>
										<#assign topinfo=true>
										<@writeInstruction value=expense.instructionTop!BLANK Instructions_URL=expense.instructionsURL!BLANK InstructionsViewReportText_URL=expense.instructionsViewReportTextURL!BLANK IsWatcherNotification=expense.isWatcherNotification!false />
										<#assign topinfo=false>
										<#assign hasline=true>
									<#elseif expense.infourls?? && expense.infourls?has_content>
										<#assign topinfo=true>
										<@writeDefaultinstruction args=expense.infourls!DUMMY_ARRAY Instructions_URL=expense.instructionsURL!BLANK InstructionsViewReportText_URL=expense.instructionsViewReportTextURL!BLANK />
										<#assign topinfo=false>
										<#assign hasline=true>
									</#if>
									<#assign hasline=false>
									<#if expense.buttontop?? && expense.buttontop?has_content>
										<#assign hasline=true>
										<@writeBottompage />
										<#assign hasline=false>
										<#if expense.hasPreApprovalIdInHeader!false>
											<@writePAButton listdata=expense.buttontop!DUMMY_ARRAY />
										<#else>
											<@writeButton button=expense.buttontop!DUMMY_ARRAY />
										</#if>
										<@writeBottompage />
									</#if>
									
									<#-- iteration by sections -->
									<#if expense.list_labels?? && expense.list_labels?has_content >
										<#list expense.list_labels as item>
											<#switch item>
												<#case "Header">
												<#case "Header_Standard">
												<#case "Header_Details">
													<@writeExpenseRow expenserowdata=expense.expenserowdata!DUMMY_ARRAY />
												<#break>
												
												<#case "Compliance">
													<@writeCompliancewarning compliancewarning=expense.compliancewarning!DUMMY_ARRAY />
													<@writeNotes listdata=expense.expenseReportNotes!DUMMY_ARRAY />
												<#break>
												
												<#case "PolicyCompliance">
													<@writePolicyCompliancewarning listdata=expense.compliancewarning!DUMMY_ARRAY />
													<@writeNotes listdata=expense.expenseReportNotes!DUMMY_ARRAY />
												<#break>
												
												<#case "Reason">
													<@writeExpensepurpose name="${replaceWithConstant('Reason for Assignment')}" listdata=expense.reasonforassignment!DUMMY_ARRAY />
												<#break>
												
												<#case "Account_Summary">
													<@writeExpenseaccountsummary name="${replaceWithConstant('Account Summary')}" listdata=expense.accountsummary!DUMMY_ARRAY />
												<#break>
												
												<#case "Expense_Summary">
													<@writeSummaries name="${replaceWithConstant('Expense Summary')}" listdata=expense.expensesummary!DUMMY_ARRAY />
												<#break>
												
												<#case "Guest_Details">
													<@writeUdadatadetail listdata=expense.udadatadetail!DUMMY_ARRAY />
												<#break>
												
												<#case "Expense_Details">
													<@writeExpensedetails_ expensedetails_=expense.expensedetailsItems!DUMMY_ARRAY listdataComplianceWarnings=expense.complianceWarningItems!DUMMY_ARRAY listdataNotes=expense.itemnotesmultilevel!DUMMY_ARRAY listdataReceipts=expense.lineItemImagesPageIndexeURLs!DUMMY_ARRAY />
												<#break>
												
												<#case "Financial_Summary">
													<@writeFinancialsummary listdata=expense.financialsummary!DUMMY_ARRAY />
												<#break>
												
												<#case "Attorney_Budget">
													<@writeAttorneyBudgetSummaries name="${replaceWithConstant('Attorney Budget')}" listdata=expense.attorneyBudgetrowdata!DUMMY_ARRAY />
												<#break>
												
												<#case "PreApproval_Summary">
													<@writePreapprovalsummary listdata=expense.preapprovalsummary!DUMMY_ARRAY />
												<#break>
											</#switch>
										</#list>
									<#else>
										<#-- something wrong with our labels will use default order -->
										<@writeSectionsDefault />
									</#if>
									<#if expense.hasPreApprovalIdInHeader!false>
										<@writePAButton listdata=expense.button!DUMMY_ARRAY />
									<#else>
										<@writeButton button=expense.button!DUMMY_ARRAY />
									</#if>
									<@writeBottompage />
								</table>
								<#-- END Report Container with Border -->
								<#-- Footer -->
								<table cellpadding="0" cellspacing="0" width="100%" style="font-size:9pt; font-weight:normal; color:#9FA4A6;">
									<#-- This will visualize both the receiptLink and the report ID -->
									<#if expense.receiptLink?? && expense.hasReportId!false >
										<@writeReceiptLink link=expense.receiptLink!BLANK reportIdLabel="${replaceWithConstant('Report ID')}" reportId="${expense.reportId!BLANK}" footer=true />
									<#elseif expense.hasReportId!false>
										<@writeID label="${replaceWithConstant('Report ID')}" value="${expense.reportId!BLANK}" footer=true/> 
									</#if>
									<#if expense.receiptLink?? && expense.hasPreApprovalIdInHeader!false >
										<@writeReceiptLink link=expense.receiptLink!BLANK reportIdLabel="${replaceWithConstant('Pre-Approval ID')}" reportId="${expense.reportId!BLANK}" footer=true />
									<#elseif expense.hasPreApprovalIdInHeader!false>
										<@writeID label="${replaceWithConstant('Pre-Approval ID')}" value="${expense.reportId!BLANK}" footer=true/> 
									</#if>
									
									<#if expense.instructionBottom??>
										<#assign topinfo = false>
										<#assign hasline = false>
										<@writeBottompage />
										<#assign hasline = false>
										<@writeInstruction value=expense.instructionBottom!BLANK Instructions_URL=expense.instructionsURL!BLANK InstructionsViewReportText_URL=expense.instructionsViewReportTextURL!BLANK IsWatcherNotification=expense.isWatcherNotification!false />
									<#elseif expense.infourlsinbottom?has_content>
										<#assign topinfo = false>
										<@writeDefaultinstruction args=expense.infourlsinbottom!DUMMY_ARRAY Instructions_URL=expense.instructionsURL!BLANK InstructionsViewReportText_URL=expense.instructionsViewReportTextURL!BLANK />
										<#assign topinfo = true>
									</#if>
									<tr>
										<td height="15" width="100%" colspan="2">
											<spanData />
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>