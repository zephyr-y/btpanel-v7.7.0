
#!/bin/bash

# 定义文件路径
INDEX_FILE="/www/server/panel/BTPanel/static/js/index.js"
BIND_FILE="/www/server/panel/data/bind.pl"
PLUGIN_FILE="/www/server/panel/data/plugin.json"

# 替换index.js中的字符串
if [ -f "$INDEX_FILE" ]; then
    sed -i "s|bind_user == 'True'|bind_user == 'XXXX'|" "$INDEX_FILE"
    echo "已修改 $INDEX_FILE"
else
    echo "$INDEX_FILE 不存在"
fi

# 删除b.pl文件
if [ -f "$BIND_FILE" ]; then
    rm -f "$BIND_FILE"
    echo "已删除 $BIND_FILE"
else
    echo "$BIND_FILE 不存在或已被删除"
fi

# 修改plugin.json文件
if [ -f "$PLUGIN_FILE" ]; then
    sed -i 's|"endtime": -1|"endtime": 999999999999|' "$PLUGIN_FILE"
    echo "已修改 $PLUGIN_FILE"
else
    echo "$PLUGIN_FILE 不存在"
fi

# 给plugin.json文件上锁
if [ -f "$PLUGIN_FILE" ]; then
    chattr +i "$PLUGIN_FILE"
    echo "已锁定 $PLUGIN_FILE"
else
    echo "无法锁定 $PLUGIN_FILE，因为文件不存在"
fi
