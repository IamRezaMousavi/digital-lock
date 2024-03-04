<map version="freeplane 1.11.5">
<!--To view this file, download free mind mapping software Freeplane from https://www.freeplane.org -->
<node TEXT="Digital Lock" FOLDED="false" ID="ID_696401721" CREATED="1610381621824" MODIFIED="1706323502518" STYLE="oval">
<font SIZE="18"/>
<hook NAME="MapStyle">
    <properties edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" show_icon_for_attributes="true" associatedTemplateLocation="template:/standard-1.6.mm" show_note_icons="true" fit_to_viewport="false"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ID="ID_271890427" ICON_SIZE="12 pt" COLOR="#000000" STYLE="fork">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="200" DASH="" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_271890427" STARTARROW="NONE" ENDARROW="DEFAULT"/>
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
<richcontent TYPE="DETAILS" CONTENT-TYPE="plain/auto"/>
<richcontent TYPE="NOTE" CONTENT-TYPE="plain/auto"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ffffff" TEXT_ALIGN="LEFT"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.selection" BACKGROUND_COLOR="#afd3f7" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#afd3f7"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important" ID="ID_67550811">
<icon BUILTIN="yes"/>
<arrowlink COLOR="#003399" TRANSPARENCY="255" DESTINATION="ID_67550811"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.flower" COLOR="#ffffff" BACKGROUND_COLOR="#255aba" STYLE="oval" TEXT_ALIGN="CENTER" BORDER_WIDTH_LIKE_EDGE="false" BORDER_WIDTH="22 pt" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#f9d71c" BORDER_DASH_LIKE_EDGE="false" BORDER_DASH="CLOSE_DOTS" MAX_WIDTH="6 cm" MIN_WIDTH="3 cm"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000" STYLE="oval" SHAPE_HORIZONTAL_MARGIN="10 pt" SHAPE_VERTICAL_MARGIN="10 pt">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,11"/>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="AutomaticEdgeColor" COUNTER="26" RULE="ON_BRANCH_CREATION"/>
<node TEXT="Modes" POSITION="bottom_or_right" ID="ID_1545848711" CREATED="1706323503202" MODIFIED="1706978797373">
<edge COLOR="#ff0000"/>
<node TEXT="Normal" ID="ID_1651552645" CREATED="1706978813439" MODIFIED="1706978817819">
<node TEXT="Keypad for enter password" POSITION="bottom_or_right" ID="ID_489659378" CREATED="1706323939406" MODIFIED="1706323965999">
<node TEXT="needs a key for active fingerprint" ID="ID_1114664815" CREATED="1706324039607" MODIFIED="1706325145477"/>
</node>
<node TEXT="Lcd for show entered keys" POSITION="bottom_or_right" ID="ID_856097763" CREATED="1706323967273" MODIFIED="1706324001844"/>
<node TEXT="sms callback is active" POSITION="bottom_or_right" ID="ID_862756478" CREATED="1706324002512" MODIFIED="1706324026855"/>
</node>
<node TEXT="Disable Mode" POSITION="bottom_or_right" ID="ID_1595894542" CREATED="1706323633620" MODIFIED="1706978833818">
<node TEXT="Lcd just show &quot;DISABLE MODE&quot;" ID="ID_1735395416" CREATED="1706324651358" MODIFIED="1706324680537"/>
<node TEXT="keypad dont work, except * key" ID="ID_683429365" CREATED="1706324682399" MODIFIED="1706324921001"/>
<node TEXT="fingerprint is off" ID="ID_810809332" CREATED="1706324925395" MODIFIED="1706324932304"/>
</node>
<node TEXT="Get Settings from keypad" POSITION="bottom_or_right" ID="ID_1132129469" CREATED="1706323577615" MODIFIED="1706978845370">
<node TEXT="Lcd show menu one by one" ID="ID_641200651" CREATED="1706324140964" MODIFIED="1706324159147"/>
<node TEXT="keypad for select any items in menu" ID="ID_1793239516" CREATED="1706324159454" MODIFIED="1706324174787"/>
</node>
<node TEXT="Get Settings from sms" ID="ID_820602666" CREATED="1706978954742" MODIFIED="1706978963694">
<node TEXT="Just run smsCallBack function" ID="ID_543048917" CREATED="1706978966597" MODIFIED="1706978985211"/>
<node TEXT="And Set new settings" ID="ID_311826121" CREATED="1706978997930" MODIFIED="1706979007862"/>
<node TEXT="And return to previous mode" ID="ID_1077467347" CREATED="1706979009074" MODIFIED="1706979040483"/>
</node>
</node>
<node TEXT="Users CRUD operations" POSITION="top_or_left" ID="ID_1137581094" CREATED="1706323519655" MODIFIED="1706324098022">
<edge COLOR="#0000ff"/>
<node TEXT="Create User" ID="ID_1386343403" CREATED="1706323647524" MODIFIED="1706323653964">
<node TEXT="after create show id and get name" ID="ID_641994044" CREATED="1706324535561" MODIFIED="1706324556718"/>
</node>
<node TEXT="Read User" ID="ID_58339664" CREATED="1706323654483" MODIFIED="1706323660365">
<node TEXT="after find show name, not id" ID="ID_383615451" CREATED="1706324559302" MODIFIED="1706324582306"/>
</node>
<node TEXT="Update User" ID="ID_292023096" CREATED="1706323660935" MODIFIED="1706323666351">
<node TEXT="get id and name for update" ID="ID_1314226037" CREATED="1706324596085" MODIFIED="1706324620158"/>
</node>
<node TEXT="Delete User" ID="ID_1718528999" CREATED="1706323667106" MODIFIED="1706323673434">
<node TEXT="get id and name for delete" ID="ID_274538526" CREATED="1706324623965" MODIFIED="1706324636274"/>
</node>
<node TEXT="Get Users" ID="ID_1206205657" CREATED="1706324963572" MODIFIED="1706324975768">
<node TEXT="return all id: name dictionary" ID="ID_1109459796" CREATED="1706325013282" MODIFIED="1706325063214"/>
</node>
<node TEXT="Delete Users" ID="ID_568318167" CREATED="1706324977420" MODIFIED="1706324987373">
<node TEXT="get secret key for delete all users" ID="ID_926505148" CREATED="1706324989201" MODIFIED="1706325009416"/>
</node>
</node>
<node TEXT="settings" POSITION="top_or_left" ID="ID_787729107" CREATED="1706324211153" MODIFIED="1706324217895">
<edge COLOR="#7c0000"/>
<node TEXT="set welcome message" ID="ID_279346041" CREATED="1706324221870" MODIFIED="1706324248102"/>
<node TEXT="set relay time" ID="ID_1361261523" CREATED="1706324249510" MODIFIED="1706324323371"/>
<node TEXT="disable sms module" ID="ID_605172384" CREATED="1706324410993" MODIFIED="1706324419255"/>
<node TEXT="change password" ID="ID_438339730" CREATED="1706324705615" MODIFIED="1706324712629"/>
<node TEXT="change secret key" ID="ID_1766757157" CREATED="1706325173090" MODIFIED="1706325182310"/>
</node>
<node TEXT="storage" POSITION="top_or_left" ID="ID_551463262" CREATED="1706324347744" MODIFIED="1706324351379">
<edge COLOR="#007c00"/>
<node TEXT="save as json" ID="ID_201941594" CREATED="1706324368909" MODIFIED="1706324373717">
<node TEXT="id: name" ID="ID_476823993" CREATED="1706324375799" MODIFIED="1706324492705"/>
</node>
</node>
<node TEXT="security" POSITION="top_or_left" ID="ID_742717336" CREATED="1706325498455" MODIFIED="1706325509386">
<edge COLOR="#7c0000"/>
<node TEXT="How to encrypt/decrypt message with one key in stm32??" ID="ID_1609740114" CREATED="1706325524748" MODIFIED="1706325586659"/>
<node TEXT="How to encrypt/decrypt message in flutter/dart?" ID="ID_1002404228" CREATED="1706325590276" MODIFIED="1706325619075"/>
</node>
<node TEXT="communication" POSITION="bottom_or_right" ID="ID_818447768" CREATED="1706979229698" MODIFIED="1706979322673">
<edge COLOR="#ff0000"/>
<node TEXT="text as json format" ID="ID_269585525" CREATED="1706979334261" MODIFIED="1706979348103">
<node TEXT="must encrypt/decrypt message" POSITION="bottom_or_right" ID="ID_1026924381" CREATED="1706325942938" MODIFIED="1706325975822"/>
</node>
<node TEXT="check mode and command" ID="ID_229335360" CREATED="1706979375804" MODIFIED="1706979408628">
<node TEXT="set settings" ID="ID_1481643062" CREATED="1706979477565" MODIFIED="1706979482310"/>
<node TEXT="send status" ID="ID_896182100" CREATED="1706979482817" MODIFIED="1706979487723"/>
</node>
</node>
<node TEXT="sms module behavior" POSITION="bottom_or_right" ID="ID_1346202214" CREATED="1706325859161" MODIFIED="1706325892800">
<edge COLOR="#00007c"/>
<node TEXT="send status" ID="ID_1673258380" CREATED="1706325894920" MODIFIED="1706325899780">
<node TEXT="What must I send??" ID="ID_1571379709" CREATED="1706326065925" MODIFIED="1706326078235"/>
</node>
<node TEXT="set settings variables from sms" ID="ID_1831151616" CREATED="1706325900800" MODIFIED="1706325941581"/>
<node TEXT="send logs" ID="ID_1784181242" CREATED="1706325982877" MODIFIED="1706325986782">
<node TEXT="new login" ID="ID_1587442088" CREATED="1706326084353" MODIFIED="1706326090563"/>
<node TEXT="new users operation done" ID="ID_932905163" CREATED="1706326091030" MODIFIED="1706326125129"/>
</node>
<node TEXT="set local time" ID="ID_1352190320" CREATED="1706326174522" MODIFIED="1706326185814"/>
</node>
<node TEXT="mobile client" POSITION="bottom_or_right" ID="ID_1326523337" CREATED="1706325392563" MODIFIED="1706325403088">
<edge COLOR="#00ff00"/>
<node TEXT="show sms logs" ID="ID_800113014" CREATED="1706325420665" MODIFIED="1706325433300"/>
<node TEXT="active any modes" ID="ID_1896788982" CREATED="1706325446945" MODIFIED="1706325456199"/>
<node TEXT="change settings variables" ID="ID_1342102583" CREATED="1706325460981" MODIFIED="1706326038086"/>
<node TEXT="show all exists users" ID="ID_1310669748" CREATED="1706325728515" MODIFIED="1706325747455"/>
</node>
<node TEXT="Hardware Tasks" POSITION="top_or_left" ID="ID_912570759" CREATED="1707061849616" MODIFIED="1707061861825">
<edge COLOR="#00ff00"/>
<node TEXT="LCD Task" ID="ID_714746849" CREATED="1707061873801" MODIFIED="1707061884068">
<node TEXT="counter" ID="ID_1177954267" CREATED="1707061887231" MODIFIED="1707061894807"/>
<node TEXT="show mode" ID="ID_1410255297" CREATED="1707061896156" MODIFIED="1707061898970"/>
</node>
<node TEXT="Keypad Task" ID="ID_421941440" CREATED="1707061903239" MODIFIED="1707061961306"/>
<node TEXT="Fingerprint Task" ID="ID_1621895631" CREATED="1707061944326" MODIFIED="1707061949531"/>
<node TEXT="GSM Task" ID="ID_1964743065" CREATED="1707061950116" MODIFIED="1707061955451"/>
</node>
</node>
</map>
