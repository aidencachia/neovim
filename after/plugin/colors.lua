function ColorMyPencils(color)
	color = color or "tokyodark"
	vim.cmd.colorscheme(color)
end

ColorMyPencils() 
