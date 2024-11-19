return {
	{ 'kana/vim-textobj-user',                      priority = 100 },
	-- 'D4KU/vim-textobj-chainmember'  " m
	{ 'pianohacker/vim-textobj-indented-paragraph', event = 'VeryLazy' }, -- r, g(  and g) for jump
	{ 'jceb/vim-textobj-uri',                       event = 'VeryLazy' }, -- iu for URL
	{ 'Julian/vim-textobj-variable-segment',        event = 'VeryLazy' }, -- v
	{ 'kana/vim-textobj-lastpat',                   event = 'VeryLazy' }, -- search pat
}
