return {
	{ 'kana/vim-textobj-user',                      priority = 100 },
	-- 'D4KU/vim-textobj-chainmember'  " m
	{ 'pianohacker/vim-textobj-indented-paragraph', event = 'VeryLazy' }, -- r, g(  and g) for jump
	{ 'jceb/vim-textobj-uri',                       event = 'VeryLazy' }, -- iu for URL
	{ 'Julian/vim-textobj-variable-segment',        event = 'VeryLazy' }, -- v
	{ 'kana/vim-textobj-lastpat',                   event = 'CmdlineEnter' }, -- / search pat
	{
		'kana/vim-textobj-line', -- . for current line
		event = 'VeryLazy',
		init = function ()
			vim.g.textobj_line_no_default_key_mappings = 1
		end,
		config = function ()
			vim.keymap.set({ 'v', 'o' }, '.', '<Plug>(textobj-line-a)')
		end
	},
}
