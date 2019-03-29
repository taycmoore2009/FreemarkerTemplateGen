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
        #maintable {width:600px;}
        @media screen and (max-width: 660px){
            #maintable{
                width:100%; max-width:600px;
            }
        }
	</style>
	
	<body style="background:#475156;">
		<table width='100%'>
            <tbody>
                <tr>
                </tr>
                <tr width='680'>
                    <td>
                        <table>
                            <tbody>
                                <tr>
                                    <td>ChromeRiver</td>
                                </tr>
                                <tr>
                                    <td style="background:#32b9ff">Action Required - Pending Approval</td>
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