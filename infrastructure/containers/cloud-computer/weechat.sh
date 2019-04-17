KEYBIND_NEXT_CHANNEL="ctrl-J"
KEYBIND_PREVIOUS_CHANNEL="ctrl-K"

/usr/bin/weechat --run-command "\
/mouse enable; \
/set irc.look.server_buffer independent; \
/set irc.look.temporary_servers on; \
\
/print -escape \n\u23e9 Customize the chat area;\
/set weechat.look.buffer_time_format "%H:%M"; \
/set weechat.look.prefix_suffix ''; \
/set weechat.look.bar_more_down "▼"; \
/set weechat.look.bar_more_left "◀"; \
/set weechat.look.bar_more_right "▶"; \
/set weechat.look.bar_more_up "▲"; \
/set weechat.look.prefix_error "❌"; \
/set weechat.look.read_marker_string "─"; \
\
/print -escape \n\u23e9 Buflist (Channel list) customization;\
/set buflist.format.buffer '\\\${format_number}\\\${indent}\\\${eval:\\\${format_name}}\\\${format_hotlist} \\\${color:31}\\\${buffer.local_variables.filter}\\\${buffer.local_variables.conky_Load_Average}\\\${buffer.local_variables.weather}'; \
/set buflist.format.buffer_current '\\\${if:\\\${type}==server?\\\${color:*white,31}:\\\${color:*white}}\\\${hide:>,\\\${buffer[last_gui_buffer].number}} \\\${indent}\\\${if:\\\${type}==server&&\\\${info:irc_server_isupport_value,\\\${name},NETWORK}?\\\${info:irc_server_isupport_value,\\\${name},NETWORK}:\\\${name}} \\\${color:31}\\\${buffer.local_variables.filter}\\\${buffer.local_variables.conky_Load_Average}\\\${buffer.local_variables.weather}'; \
/set buflist.format.hotlist ' \\\${color:239}\\\${hotlist}\\\${color:239}'; \
/set buflist.format.hotlist_highlight '\\\${color:163}'; \
/set buflist.format.hotlist_message '\\\${color:229}'; \
/set buflist.format.hotlist_private '\\\${color:121}'; \
/set buflist.format.indent '\\\${if:\\\${type}==channel&&\\\${buffer.name}=~fr\\\$||\\\${info:aspell_dict,\\\${buffer.full_name}}=~fr?\\\${color:blue}f :  }\\\${color:*white}'; \
/set buflist.format.name '\\\${if:\\\${type}==server?\\\${color:white}:\\\${color_hotlist}}\\\${if:\\\${type}==server||\\\${type}==channel||\\\${type}==private?\\\${if:\\\${cutscr:8,+,\\\${name}}!=\\\${name}?\\\${cutscr:8,\\\${color:\\\${weechat.color.chat_prefix_more}}+,\\\${if:\\\${type}==server&&\\\${info:irc_server_isupport_value,\\\${name},NETWORK}?\\\${info:irc_server_isupport_value,\\\${name},NETWORK}:\\\${name}}}:\\\${cutscr:8, ,\\\${if:\\\${type}==server&&\\\${info:irc_server_isupport_value,\\\${name},NETWORK}?\\\${info:irc_server_isupport_value,\\\${name},NETWORK}                              :\\\${name}                              }}}:\\\${name}}'; \
/set buflist.format.number '\\\${if:\\\${type}==server?\\\${color:black,31}:\\\${color:239}}\\\${if:\\\${number_displayed}?.: }'; \
/set weechat.bar.buflist.size_max 18; \
/set weechat.bar.buflist.size 18; \
\
/print -escape \n\u23e9 Init and customize our own activetitle;\
/bar del activetitle; \
/bar add activetitle window top 1 0 buffer_title; \
/set weechat.bar.activetitle.priority 500; \
/set weechat.bar.activetitle.color_fg white; \
/set weechat.bar.activetitle.color_bg 31; \
/set weechat.bar.activetitle.separator on; \
/set weechat.bar.activetitle.conditions '\\\${active}'; \
/set weechat.bar.title.color_fg black; \
/set weechat.bar.title.color_bg 31; \
/set weechat.bar.title.conditions '\\\${inactive}'; \
\
/print -escape \n\u23e9 Replace default status bar (2nd to bottom) with our own; \
/bar add rootstatus root bottom 1 0 [time],[buffer_count],[buffer_plugin],buffer_number+:+buffer_name+(buffer_modes)+{buffer_nicklist_count}+buffer_filter,[bitlbee_typing_notice],[lag],[aspell_dict],[aspell_suggest],completion,scroll; \
/set weechat.bar.rootstatus.color_fg 31; \
/set weechat.bar.rootstatus.color_bg 234; \
/set weechat.bar.rootstatus.separator on; \
/set weechat.bar.rootstatus.priority 500; \
/bar set rootstatus name status; \
/set weechat.color.status_time *_214; \
/bar del status; \
\
/print -escape \n\u23e9 Replace default input bar (bottom) with our own; \
/bar add rootinput root bottom 1 0 [buffer_name]+[input_prompt]+(away),[input_search],[input_paste],input_text; \
/set weechat.bar.rootinput.color_bg black; \
/set weechat.bar.rootinput.priority 1000; \
/bar del input; \
/bar set rootinput name input; \
\
/print -escape \n\u23e9 Customize the nicklist bar; \
/set weechat.bar.nicklist.color_fg 229; \
/set weechat.bar.nicklist.separator on; \
/set weechat.bar.nicklist.size_max 14; \
/set weechat.bar.nicklist.size 14; \
/set weechat.bar.nicklist.conditions '\\\${nicklist} && \\\${window.number} == 1 && \\\${buffer.full_name} !~ ^irc.freenode.(#newsbin|##news)$'; \
\
/print -escape \n\u23e9 Connecting to Gitter...; \
/connect irc://$CLOUD_COMPUTER_GITTER_USERNAME:$CLOUD_COMPUTER_GITTER_TOKEN@irc.gitter.im/#hashicorp/terraform,#Microsoft/typescript -ssl; \
\
/print -escape \n\u23e9 Connecting to Freenode...; \
/connect irc://$CLOUD_COMPUTER_FREENODE_USERNAME:$CLOUD_COMPUTER_FREENODE_PASSWORD@chat.freenode.net:6697/#cloudflare,#docker,#javascript,#nodejs,#ubuntu,#winswitch,#zsh; \
\
/print -escape \n\u23e9 Connecting to Riot...; \
/set plugins.var.lua.matrix.user $CLOUD_COMPUTER_MATRIX_USERNAME; \
/set plugins.var.lua.matrix.password $CLOUD_COMPUTER_MATRIX_PASSWORD; \
/matrix connect; \
\
/print -escape \n\u23e9 Connecting to Kubernetes Slack...; \
/set plugins.var.python.slack.slack_api_token $CLOUD_COMPUTER_SLACK_KUBERNETES_TOKEN; \
\
/print -escape \n\u23e9 Filtering init (safe to ignore error); \
/filter del joinquit; \
/filter add joinquit * irc_join,irc_part,irc_quit *; \
\
/print -escape \n\u23e9 Setup keybindings; \
/key bind $KEYBIND_NEXT_CHANNEL /buffer +1; \
/key bind $KEYBIND_PREVIOUS_CHANNEL /buffer -1; \
"
