local PANEL = {}


function PANEL:Init()
	self.OverheadText = ""
	self.OverheadFont = "ScoreboardText"
	self.OverheadColor = Color(255,0,0,255)
	self.OverheadTextAlign = TEXT_ALIGN_CENTER
end

function PANEL:Paint()
  draw.RoundedBox(6,50,50,self:GetWide(),self:GetTall(),Color(0,0,0,0))
  draw.DrawText( self.OverheadText, self.OverheadFont, x, 0, self.OverheadColor, self.OverheadTextAlign )
  return true
end

-- This function is called whenever this control is pressed
function PANEL:OnMousePressed()
end

function PANEL:SetOverheadText(text)
	self.OverheadText = text
end

function PANEL:SetOverheadFont(font)
	self.OverheadFont = font
end

function PANEL:SetOverheadColor(r,g,b,a)
	if a == nil then
		self.OverheadColor = Color(r,g,b,255)
	else
		self.OverheadColor = Color(r,g,b,a)
	end
end

function PANEL:SetOverheadAlign(align)
	self.OverheadTextAlign = align
end

vgui.Register( "OPPPanel", PANEL )
