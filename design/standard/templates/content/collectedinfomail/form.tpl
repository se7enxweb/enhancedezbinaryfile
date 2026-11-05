{* The mail of collected information for the forms of this installation.

   On an Exponential kernel with the HTML mail layout (notification.ini [MailSettings] HTMLLayout is the setting that
   came with it) the mail is the kernel's: an HTML part and a plain-text part from content/collectedinfomail_body.tpl
   and design:mail/layout.tpl. ci_mail=true() passes mail=true() to each answer's "info" view, so the view of an
   uploaded file (content/datatype/result/info/enhancedezbinaryfile.tpl) writes its mail form, with the file's link
   for the groups that may see it (module.ini [Security] FullPathMail).
   On an older kernel the mail stays the plain text it always was. *}
{def $ebf_html_mail = ezini_hasvariable( 'MailSettings', 'HTMLLayout', 'notification.ini' )}
{* The subject is a mail header, text: the object's name as it is (washed only in the old plain-text mail, as before) *}
{if $ebf_html_mail}
{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/standard/content/edit",,array($collection.object.name))}{/set-block}
{else}
{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/standard/content/edit",,array($collection.object.name|wash))}{/set-block}
{/if}

{* Use this line to specify the email in the template, can read this from the object to
   make it dynamic pr form
{set-block scope=root variable=email_receiver}nospam@ez.no{/set-block}
*}

{* Set this to redirect to another node
{set-block scope=root variable=redirect_to_node_id}2{/set-block}
*}

{if $ebf_html_mail}
{include uri='design:content/collectedinfomail_body.tpl' collection=$collection ci_gui=true() ci_mail=true()
         ci_title="Collected information from %1"|i18n("design/standard/content/edit",,array($collection.object.name))
         ci_intro="The following information was collected"|i18n("design/standard/content/edit")}
{else}
{"The following information was collected"|i18n("design/standard/content/edit")}:

{foreach $collection.attributes as $Attribute}
{$Attribute.contentclass_attribute_name|wash}:
	{attribute_result_gui view=info attribute=$Attribute mail=true()}
	{*show_fullpath is to allow the full path of the collected info to be shown in the admin mail sent WITHOUT it necessarily being shown to the
	user on the front end.*}
{/foreach}
{/if}
{undef $ebf_html_mail}
