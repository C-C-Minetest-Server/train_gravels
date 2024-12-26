-- train_gravels/init.lua
-- Gravel-related blocks for advtrains
--[[
    Copyright © 2011-2024 Hugo Locurcio and contributors.
    Licensed under the zlib license. See LICENSE.md for more information.
]]

local S = minetest.get_translator("train_gravels")

local sound_gravel = default.node_sound_gravel_defaults()

-- Gravel Stonebrick

for name, def in pairs({
    gravel_stonebrick = {
        description = S("Gravel on Stone Brick"),
        texture = "default_stone_brick.png",
        recipe_item = "default:stonebrick",
    },
    gravel_desert_stonebrick = {
        description = S("Gravel on Desert Stone Brick"),
        texture = "default_desert_stone_brick.png",
        recipe_item = "default:desert_stonebrick",
    },
    gravel_sandstonebrick = {
        description = S("Gravel on Sandstone Brick"),
        texture = "default_sandstone_brick.png",
        recipe_item = "default:sandstonebrick",
    },
    gravel_silver_sandstone_brick = {
        description = S("Gravel on Silver Sandstone Brick"),
        texture = "default_silver_sandstone_brick.png",
        recipe_item = "default:silver_sandstone_brick",
    },
    gravel_iron_stone_bricks = {
        description = S("Gravel on Iron Stone Bricks"),
        texture = "moreblocks_iron_stone_bricks.png",
        recipe_item = "moreblocks:iron_stone_bricks",
    },
    gravel_coal_stone_bricks = {
        description = S("Gravel on Coal Stone Bricks"),
        texture = "moreblocks_coal_stone_bricks.png",
        recipe_item = "moreblocks:coal_stone_bricks",
    },
    gravel_granite_bricks = {
        description = S("Gravel on Granite Bricks"),
        texture = "technic_granite_bricks.png",
        recipe_item = "technic:granite_bricks",
    },
    gravel_marble_bricks = {
        description = S("Gravel on Marble Bricks"),
        texture = "technic_marble_bricks.png",
        recipe_item = "technic:marble_bricks",
    },
    gravel_stone_tile = {
        description = S("Gravel on Stone Tile"),
        texture = "moreblocks_split_stone_tile.png",
        bottom_texture = "moreblocks_stone_tile.png",
        recipe_item = "moreblocks:stone_tile",
    },
    gravel_split_stone_tile = {
        description = S("Gravel on Split Stone Tile"),
        texture = "moreblocks_split_stone_tile.png",
        recipe_item = "moreblocks:split_stone_tile",
    },
}) do
    if minetest.registered_items[def.recipe_item] then
        local side_texture = "default_gravel.png^[lowpart:50:" .. def.texture
        minetest.register_node("train_gravels:" .. name, {
            description = def.description,
            tiles = {
                "default_gravel.png",
                def.bottom_texture or def.texture,
                side_texture,
                side_texture,
                side_texture,
                side_texture
            },
            groups = { cracky = 3 },
            sounds = sound_gravel,
        })

        minetest.register_craft({
            output = "train_gravels:" .. name .. " 2",
            recipe = {
                { "default:gravel" },
                { def.recipe_item },
            }
        })
    end
end

minetest.register_alias("moreblocks:gravel_stonebrick", "train_gravels:gravel_stonebrick")

-- Gravel Slopes

local slopes = {
    ["2a"] = "half",
    ["2b"] = "half_raised",

    ["3a"] = "third",
    ["3b"] = "third_raised",
    ["3c"] = "third_top"
}

local box = {
    ["2a"] = {
        type = "fixed",
        fixed = {
            { -0.5, -0.5,   -0.5,  0.5, -0.375, 0.5 },
            { -0.5, -0.375, -0.25, 0.5, -0.25,  0.5 },
            { -0.5, -0.25,  0,     0.5, -0.125, 0.5 },
            { -0.5, -0.125, 0.25,  0.5, 0,      0.5 },
        }
    },
    ["2b"] = {
        type = "fixed",
        fixed = {
            { -0.5, -0.5,  -0.5,  0.5, 0.125, 0.5 },
            { -0.5, 0.125, -0.25, 0.5, 0.25,  0.5 },
            { -0.5, 0.25,  0,     0.5, 0.375, 0.5 },
            { -0.5, 0.375, 0.25,  0.5, 0.5,   0.5 },
        }
    },

    ["3a"] = {
        type = "fixed",
        fixed = {
            { -0.5, -0.5,   -0.5,  0.5, -0.417, 0.5 },
            { -0.5, -0.417, -0.25, 0.5, -0.333, 0.5 },
            { -0.5, -0.333, 0,     0.5, -0.250, 0.5 },
            { -0.5, -0.250, 0.25,  0.5, -0.167, 0.5 },
        }
    },
    ["3b"] = {
        type = "fixed",
        fixed = {
            { -0.5, -0.5,   -0.5,  0.5, -0.083, 0.5 },
            { -0.5, -0.083, -0.25, 0.5, 0,      0.5 },
            { -0.5, 0,      0,     0.5, 0.083,  0.5 },
            { -0.5, 0.083,  0.25,  0.5, 0.167,  0.5 },
        }
    },
    ["3c"] = {
        type = "fixed",
        fixed = {
            { -0.5, -0.5,  -0.5,  0.5, 0.250, 0.5 },
            { -0.5, 0.250, -0.25, 0.5, 0.333, 0.5 },
            { -0.5, 0.333, 0,     0.5, 0.417, 0.5 },
            { -0.5, 0.417, 0.25,  0.5, 0.5,   0.5 },
        }
    }
}

for id, mod in pairs(slopes) do
    minetest.register_node("train_gravels:gravel_slope_" .. id, {
        description = S("Gravel Slope @1", id),
        tiles = { "default_gravel.png" },
        groups = { crumbly = 2, falling_node = 1, not_blocking_trains = 1 },
        sounds = sound_gravel,
        drawtype = "mesh",
        mesh = "train_gravels_slope_" .. mod .. ".obj",
        selection_box = box[id],
        collision_box = box[id],
        sunlight_propagates = false,
        light_source = 0,
        paramtype = "light",
        paramtype2 = "facedir",
        on_rotate = screwdriver and screwdriver.rotate_simple,
        is_ground_content = false,
    })

    minetest.register_alias("moreblocks:gravel_slope_" .. id, "train_gravels:gravel_slope_" .. id)
end

-- 1:1 slope

local box_slope = {
    type = "fixed",
    fixed = {
        { -0.5, -0.5,  -0.5,  0.5, -0.25, 0.5 },
        { -0.5, -0.25, -0.25, 0.5, 0,     0.5 },
        { -0.5, 0,     0,     0.5, 0.25,  0.5 },
        { -0.5, 0.25,  0.25,  0.5, 0.5,   0.5 }
    }
}

minetest.register_node("train_gravels:gravel_slope", {
    description = S("Gravel Slope @1", "1"),
    tiles = { "default_gravel.png" },
    groups = { crumbly = 2, falling_node = 1, not_blocking_trains = 1 },
    sounds = sound_gravel,
    drawtype = "mesh",
    mesh = "train_gravels_slope.obj",
    selection_box = box_slope,
    collision_box = box_slope,
    sunlight_propagates = false,
    light_source = 0,
    paramtype = "light",
    paramtype2 = "facedir",
    on_rotate = screwdriver and screwdriver.rotate_simple,
    is_ground_content = false,
})

minetest.register_alias("moreblocks:gravel_slope", "train_gravels:gravel_slope")

-- Advtrains Track Slope (Straight) hitbox fix

if minetest.get_modpath("advtrains_train_track") then
    local vst_map = {
        vst1 = "2a",
        vst2 = "2b",

        vst31 = "3a",
        vst32 = "3b",
        vst33 = "3c"
    }

    for orig, id in pairs(vst_map) do
        minetest.override_item("advtrains:dtrack_" .. orig, {
            walkable = true,
            selection_box = box[id],
            collision_box = box[id],
        })
    end
end

-- Recipies

minetest.register_craft({
    output = "moreblocks:gravel_slope 6",
    recipe = {
        { "", "",               "" },
        { "", "",               "default:gravel", },
        { "", "default:gravel", "default:gravel" },
    }
})

minetest.register_craft({
    output = "moreblocks:gravel_slope_2a 8",
    recipe = {
        { "", "",               "" },
        { "", "",               "", },
        { "", "default:gravel", "default:gravel" },
    }
})

minetest.register_craft({
    output = "moreblocks:gravel_slope_2b 4",
    recipe = {
        { "", "",               "default:gravel", },
        { "", "",               "" },
        { "", "default:gravel", "default:gravel" },
    }
})

minetest.register_craft({
    output = "moreblocks:gravel_slope_3a 18",
    recipe = {
        { "",               "",               "" },
        { "",               "",               "", },
        { "default:gravel", "default:gravel", "default:gravel" },
    }
})

minetest.register_craft({
    output = "moreblocks:gravel_slope_3b 8",
    recipe = {
        { "",               "",               "" },
        { "",               "",               "default:gravel", },
        { "default:gravel", "default:gravel", "default:gravel" },
    }
})

minetest.register_craft({
    output = "moreblocks:gravel_slope_3c 6",
    recipe = {
        { "",               "",               "default:gravel", },
        { "",               "default:gravel", "" },
        { "default:gravel", "default:gravel", "default:gravel" },
    }
})

minetest.register_craft({
    output = "default:gravel",
    recipe = {
        { "moreblocks:gravel_slope_2a", "", "" },
        { "moreblocks:gravel_slope_2b", "", "" },
        { "",                           "", "" },
    }
})

minetest.register_craft({
    output = "default:gravel",
    recipe = {
        { "moreblocks:gravel_slope_3b", "", "" },
        { "moreblocks:gravel_slope_3b", "", "" },
        { "",                           "", "" },
    }
})

minetest.register_craft({
    output = "default:gravel",
    recipe = {
        { "moreblocks:gravel_slope_3a", "", "" },
        { "moreblocks:gravel_slope_3c", "", "" },
        { "",                           "", "" },
    }
})
