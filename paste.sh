t=@\"$1\"
cycript -p SpringBoard<< EOF
x=[UIPasteboard generalPasteboard ]
ret=[x setString:$t]
EOF
