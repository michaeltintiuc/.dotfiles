autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx :silent call CocAction('runCommand', 'tsserver.organizeImports') | :silent call CocAction('runCommand', 'editor.action.fixAll')
autocmd BufWritePre *.md :silent call CocAction('runCommand', 'markdownlint.fixAll')
autocmd BufWritePre *.json :silent %!jq --sort-keys .
