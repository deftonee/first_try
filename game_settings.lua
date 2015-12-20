
panelHeight = 60
wallThickness = 10
fieldHeight = director.displayHeight - panelHeight
fieldWidth = director.displayWidth


--initial_impulse = {5, 7, 0, 0}
bodyType = 1
figures_num = 3

triCoordsBody = {0,0, 95,0, 48,81}
triCoordsDraw = {0,0, 95,0, 48,81,    0,0 }

fontHeight = 15
fontDesignWidth = 320
graphicDesignWidth = 768


fontScale = director.displayWidth / fontDesignWidth	-- Font is correct size on 320 wide screen so we scale to match native screen size
actualFontHeight = fontHeight * fontScale			-- The actual pixel height of the font
graphicsScale = director.displayWidth / graphicDesignWidth	-- Graphics are designed for 768 wide screen so we scale to native screen size
--defaultFont = director:createFont("fonts/ComicSans24.fnt")	-- The default font


wall_params = {
    left={
        x=0, y=0,
        w= wallThickness, h=fieldHeight,
        xAnchor=0, yAnchor=0,
        color=color.black
    },
    right={
        x=director.displayWidth, y=0,
        w= wallThickness, h=fieldHeight,
        xAnchor=1, yAnchor=0,
        color=color.black
    },
    upper={
        x=0, y=fieldHeight,
        w=director.displayWidth, h= wallThickness,
        xAnchor=0, yAnchor=1,
        color=color.black
    },    
    bottom={
        x=0, y=0,
        w=director.displayWidth, h= wallThickness,
        xAnchor=0, yAnchor=0,
        color=color.black
    },    
}