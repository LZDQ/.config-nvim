local yaml = require("yaml_nvim")
yaml.setup{}

require('lualine').setup{
	sections = {
		lualine_c = { 'filename', yaml.get_yaml_key }
	}
}
