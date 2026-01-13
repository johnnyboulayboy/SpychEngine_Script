local jauve

function onCreatePost()
    jauve = 0

    makeLuaSprite('InLine', '\\Jauve\\InLine', 10, 0)
    scaleObject('InLine', 0.5,0.5)
    setObjectCamera('InLine', 'hud')
    screenCenter('InLine', 'Y')
    addLuaSprite('InLine', true)
    
    makeLuaSprite('OutLine', '\\Jauve\\OutLine', 10, 0)
    scaleObject('OutLine', 1,1)
    setObjectCamera('OutLine', 'hud')
    screenCenter('OutLine', 'Y')
    addLuaSprite('OutLine', true)

    makeLuaText('jauvet', tostring(jauve), 0, 40, 0) -- checking if that work with a older script I made
    scaleObject('jauvet', 1, 1)
    screenCenter('jauvet', 'Y')
    addLuaText('jauvet')
end

function onUpdate()
    if jauve >= 100 then
        setTextColor('jauvet', '00FF00')
        jauve = 100 -- evite les 100.5 et autre.
        if keyboardJustPressed('SPACE') then
            jauve = 0
            local life = getHealth('bf')
            setHealth(life + 0.2)
        end
    else
        if difficultyName == 'Hard' then
            if jauve >= 70 then
                setTextColor('jauvet', 'FFFF00')
                if keyboardJustPressed('SPACE') then
                    jauve = jauve - 70
                    local life = getHealth('bf')
                    setHealth(life + 0.05)
                end
            else
                setTextColor('jauvet', 'FFFFFF')
            end
        else
            if jauve >= 50 then
                setTextColor('jauvet', 'FFFF00')
                if keyboardJustPressed('SPACE') then
                    jauve = jauve - 50
                    local life = getHealth('bf')
                    setHealth(life + 0.05)
                end
            else
                setTextColor('jauvet', 'FFFFFF')
            end
            -- jauve = jauve + 1
        end
    end
    setTextString('jauvet', limitChars(tostring(jauve), 4))
    scaleObject('InLine', 0.5, jauve*0.005)
    -- local iy = getProperty('InLine.y') -- Innutile, cassais le jeux sans raison
    -- setProperty('InLine.y', iy + jauve) 
end

function onUpdateScore(miss)
	if miss then
        if difficultyName  == 'Hard' then
            if jauve > 0 then
                jauve = jauve - 0.2
            else
                jauve = 0
            end
        else
            jauve = jauve + 0.2
        end
    else
        if difficultyName == 'Hard' then
            jauve = jauve + 0.3
        else
            jauve = jauve + 1 -- pas de répétition sur les slider
        end
    end
end

function limitChars(text, max)
    return string.sub(text, 1, max)
end
