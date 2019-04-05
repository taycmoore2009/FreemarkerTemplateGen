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
    <style type='text/css'>
        @media only screen and (max-width:480px),
            only screen and (resolution: 4dppx) and (max-width: 1440px) {
                .mainTable {
                    max-width: 360px;
                }
                .main-table_first-td {
                    padding: 15px 10px 0 !important;
                }
                .mobile_td_full-width {
                    display: inline-block;
                    width: 100%;
                    text-align: left !important;
                }
                .mobile_remove-border {
                    border: none !important;
                    padding: 0 !important;
                }
                .mobile_hidden {
                    display: none;
                }
                .mobile_td-hidden {
                    width: 0 !important;

                }
                .mobile_span-show {
                    display: inline !important;;
                }
                .btnTable_td {
                    display: inline-block;
                    padding: 5px 0 !important;
                }
                .btnTable_td table,
                .btnTable_td td {
                    width: 100% !important;
                }
                .btnTable_view {
                    width: 100%;
                }
                .btnTable_return {
                    width: 50%;
                }
                .btnTable_approve {
                    width: 50%;
                }
        }
	</style>
	
	<body style="background:#475156; color: #475156; font-family: 'Arial'; font-family: 'Open Sans', 'OpenSans', 'opensans', 'Sans Serif', 'SansSerif', sans-serif, 'Arial';">
		<table width='100%'>
            <tbody>
                <tr>
                </tr>
                <tr class='mainTable' align="center">
                    <td>
                        <table class='mainTable' style='max-width: 680px; text-align: left; border-collapse: collapse;'>
                            <tbody>
                                <tr>
                                    <td style='text-align: center; padding: 20px 0px 24px;'><img src='css/img/email/CR-logo.png'/></td>
                                </tr>
                                <tr>
                                    <td style="background:#31b4cb; text-align: center; color: #FFFFFF; padding: 17px 0 18px; font-size: 14px; border-radius: 5px 5px 0 0; text-transform: uppercase;">
                                        Action Required - Pending Approval
                                    </td>
                                </tr>
                                <tr style='background: #FFFFFF;'>
                                    <td style='padding: 15px 30px 0px;' class='main-table_first-td'>
                                        <table style='border-collapse: collapse; font-size: 14px; font-weight: 300;'>
                                            <tbody>
                                                <!-- Header Stuff-->
                                                <tr>
                                                    <td colspan='2' style='color: #58c4d7; font-size: 18px; font-weight: 600;'>
                                                        Expense Title Goes Here
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan='2' style="padding: 7px 0px;">
                                                        Business purpose of this expense reoprt goes here. If it's too long, wrap text to another line. Business purpose of this expense report goes here. If it's too long, wrap text to another line.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style='color: #9fa4a6; text-align: left; padding: 6px 0px 12px;' class='mobile_td_full-width'>
                                                        Expense ID: 0100-2221-1405
                                                    </td>
                                                    <td style='text-align: right; padding: 6px 0px 12px;' class='mobile_td_full-width'>
                                                        <a href='#a' style='color: #aae1eb; padding: 0px 0px 12px;'>View Full Report</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style='text-align: left; padding-bottom: 20px;' class='mobile_td_full-width'>
                                                        Expense for James Brown<br/>
                                                        <span style='color: #9fa4a6; padding-bottom: 32px;'>Created by Jim Scott<br/>
                                                        UDA goes here: UDA Information<br/>
                                                        UDA Title: UDA Value</span>
                                                    </td>
                                                    <td style='text-align: right; padding-bottom: 32px;' class='mobile_td_full-width'>
                                                        During 01/01/2019/ - 01/02/2019<br/>
                                                        <span style='color: #9fa4a6;'>Submitted on 02/10/2019</span>
                                                    </td>
                                                <!-- Warning stuff -->
                                                <tr>
                                                    <td colspan='2' style='padding: 5px 0px;'>
                                                        <table width='100%' style='background: #fceedb; width: 100%; border-radius: 5px; padding: 5px 10px; font-size: 11px; font-weight: 400;'>
                                                            <tbody>
                                                                <tr>
                                                                    <td colspan='2' style='color: #f0ad4e; font-weight: 600; padding: 0px 0px 5px; font-size: 12px;'>
                                                                        >> 301: Submit Compliance
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width='82px' style='text-transform: uppercase; color: #9fa4a6; padding: 0px 10px 0px 0px'>Response</td>
                                                                    <td style='color: #475156;'>Busy season charged. Planned last minute.</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan='2' style='padding: 5px 0px;'>
                                                        <table width='100%' style='background: #fceedb; width: 100%; border-radius: 5px; padding: 5px 10px; font-size: 11px; font-weight: 400;'>
                                                            <tbody>
                                                                <tr>
                                                                    <td colspan='2' style='color: #f0ad4e; font-weight: 600; padding: 0px 0px 5px; font-size: 12px;'>
                                                                        >> 301: Submit Compliance
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width='82px' style='text-transform: uppercase; color: #9fa4a6; padding: 0px 10px 0px 0px'>Response</td>
                                                                    <td style='color: #475156;'>Busy season charged. Planned last minute.</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <!-- Approval Info -->
                                                <tr>
                                                    <td colspan='2' style='padding: 20px 0;'>
                                                        <@tables title="Prior Approvers" rows=expense.approvers />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan='2' style='padding: 20px 0;'>
                                                        <table style='width: 100%; border-collapse: collapse;'>
                                                            <tbody>
                                                                <tr>
                                                                    <td style='font-weight: 600; padding-bottom: 7px;'>
                                                                        Reason for Assign
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style='border-top: 1px solid #e7e9ea; border-bottom: 1px solid #e7e9ea; padding: 7px 0;'>
                                                                        Company wide audit for 2019
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <!-- Comments -->
                                                <tr>
                                                    <td colspan='2'  style='padding: 20px 0;'>
                                                        <@commentTable rows=expense.comments />
                                                    </td>
                                                </tr>
                                                <!-- Financial Summary -->
                                                <tr>
                                                    <td colspan='2'  style='padding: 20px 0;'>
                                                        <@tables title="Financial Summary" rightHeader=expense.financialSummary.currency rows=expense.financialSummary.rows footer=expense.financialSummary.footer/>
                                                    </td>
                                                </tr>
                                                <!-- Account Summary -->
                                                <tr>
                                                    <td colspan='2' style='padding: 20px 0;'>
                                                        <@accountSummaryTable title='Account Summary' rows=expense.accountSummary.Account  currency='USD' totals=expense.accountSummary.Totals />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan='2' style='padding: 20px 0;'>
                                                        <@expenseSummaryTable title='Expense Summary' rows=expense.expenseSummary.expenses currency=expense.expenseSummary.currency totals=expense.expenseSummary.totals />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan='2' style='padding: 20px 0'>
                                                        <@buttonsTable />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr style='background: #FFFFFF;'>
                                    <td style='padding: 15px 30px 0px; border-top: 10px solid;'>
                                        <table width='100%' style='width: 100%; border-collapse: collapse; font-size: 14px; font-weight: 300;'>
                                            <tbody>
                                                <!-- Guest Details -->
                                                <tr>
                                                    <td colspan='2' style='padding: 20px 0;'>
                                                        <@guestDetailsTable rows=expense.guestDetails />
                                                    </td>
                                                </tr>
                                                <!-- Expense Details -->
                                                <tr>
                                                    <td colspan='2' style='padding: 20px 0 0;'>
                                                        <@expenseDetailsTable expenseDetails=expense.expenseDetails currency='USD' recieptURL=expense.recieptURL />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan='2' style='padding: 20px 0'>
                                                        <@buttonsTable />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' style='text-align: center; color: #9fa4a6; font-size: 12px; padding: 30px;'>
                                        APPROVE: <a href='${expense.approveURL}' style='color: #31b4cb;'>${expense.approveText}</a> | RETURN: <a href='${expense.returnURL}' style='color: #31b4cb;'>${expense.approveText}</a><br>
                                        To view these expenses online, go to Chrome River App.
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                </tr>
            </tbody>
        </table>
	</body>
</html>