
describe:
	echo "===Project Directory Structure:\n" > file_describe.txt
	tree -I "file_describe.txt|Makefile" >> file_describe.txt

	echo "\n\n\n=== bootstrap.sh:\n" >> file_describe.txt
	cat bootstrap.sh >> file_describe.txt

# 	echo "\n\n\n=== install/alpine.sh:\n" >> file_describe.txt
# 	cat install/alpine.sh >> file_describe.txt	

# 	echo "\n\n\n=== install/common.sh:\n" >> file_describe.txt
# 	cat install/common.sh >> file_describe.txt	

# 	echo "\n\n\n=== install/debian.sh:\n" >> file_describe.txt
# 	cat install/debian.sh >> file_describe.txt	

# 	echo "\n\n\n=== install/macos.sh:\n" >> file_describe.txt
# 	cat install/macos.sh >> file_describe.txt	

# 	echo "\n\n\n=== install/macos.sh:\n" >> file_describe.txt
# 	cat install/macos.sh >> file_describe.txt	
	
# 	echo "\n=== starship/starship.toml:\n" >> file_describe.txt
# 	cat starship/starship.toml >> file_describe.txt	
	
	echo "\n\n\n=== zsh/aliases.zsh:\n" >> file_describe.txt
	cat zsh/aliases.zsh >> file_describe.txt	
	
	echo "\n\n\n=== zsh/options.zsh:\n" >> file_describe.txt
	cat zsh/options.zsh >> file_describe.txt	
	
# 	echo "\n\n\n=== zsh/plugins.zsh:\n" >> file_describe.txt
# 	cat zsh/plugins.zsh >> file_describe.txt	
	
	echo "\n\n\n=== zsh/.zshrc:\n" >> file_describe.txt
	cat zsh/.zshrc >> file_describe.txt	