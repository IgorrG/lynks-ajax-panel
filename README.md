Replacement for FOP panel
=========================

Get lower system load and better perfomance!
The company offers a community Lynks simplified version of the alternative operator's control panel calls for changes in the Asterisk standard in many distros Flash Operator Panel. The main desire was to get rid of the FOP at all, because it is very heavy as a system (due to the fact that the backend is written in Perl), and the client machine (because of the slow Flash technology), which limited the use of telephone systems with a maximum of 50 subscribers. Despite the beautiful appearance, the usual FOP is not highly thought of in terms of use and in practice has remained unclaimed. The new version, FOP2 built on AJAX technology, but the free version contains a number of limitations. 

Functional
The panel does not track the number of simultaneous channels to any extensions, and will be shown the latest in the formed list, which is equivalent to a random choice. The panel has a line of search and sorting. Possible to sort only the ascending numbers or names. A search string can search by number and name at the same time and has two modes: full-text, which matches are sought from any location, and the search is strictly from the beginning of the line, which you need to input search string, add one space. Supports basic call control functions: dialing and transfer the current call, for which special field the user can enter your phone number. To save the number of browser cookies may be noted the check box "Save". Dialing can be done in two ways: You can enter the number in the search field and click the Call button or Enter (on keyboard), or click the Call button and choose the person with whom to connect. Call transfer is only possible if the subscriber has spoken channel: Transfer button should be highlighted. Translation can also be done using a text search field or by selecting a subscriber.

Technical Features
The proposed AJAX Panel do not contain any restrictions on the number of subscribers in the system and is designed to provide maximum system performance and user convenience. The program understands the configuration files FOP, but takes from them, only data about the buttons and their membership applications, trunks or users. The position of the buttons on the screen depends only on the display option by name or number. It is also not perceived color field, a signature for them and other formatting. It is understood that the system is not possible to match the channel number, even for different technologies. For example, if there is SIP/100, then there should not be, for example, ZAP/100. This is primarily due to the fact, to simplify the analysis of real interconnect without local channels. It happens that the call to the number SIP/100 going through the channel LOCAL/100 @ from-internal, which is in reality connected with SIP/100. This imposes some restrictions, which are easily bypassed. For example, the three-digit channel numbers ZAP appear when a large number of channels, such as four streams of E1, which itself is designed for a large company, but for a company three-digit numbering cramped. On the other hand, this approach allows you to track any link at all to anyone, even the virtual extensions. If you are using FreePBX problems with this feature should not be. It supports all modern browsers, but testing was performed only with Google Chrome and Mozilla Firefox. Prolonged work with the panel in Google Shrome may lead to memory leaks on the client machine. The solution is simple: periodically (eg once per hour) to reload the page.

Installation
You should replace all the contents of the directory / panel files from the archive, except for files and op_buttons_additional.cfg op_buttons_custom.cfg (or restart after changing the configuration of FreePBX. Also, for normal operation requires that the macro-dial after

exten => s,n+2(normdial),noop(==normdial==)
were added the following lines:

exten => s,n,Set(DB(CURRCALL/${EXTTOCALL}/NUM)=${CALLERID(num)})
exten => s,n,Set(DB(CURRCALL/${EXTTOCALL}/NAME)=${CALLERID(name)})
To connect to the file extensions-realtime.php need to add connectivity options

define ("HOST", 'localhost');
define ("PORT", "5432");
define ("USER", 'asteriskuser');
define ("PASS", '4 nccnuQcYbD4VZRc ');
define ("DBNAME", "asterisk");
define ("DB_TYPE", "mysql");
After these steps, the panel will be available at http://SERVER_IP/panel Terms of Use The source code is distributed as a licensed GPLv2. No warranty, you use this software at your own risk. Signed "Developed by Lynks.ru 2010" at the bottom of this page is required for any use of the program.
