-- train_gravels/init.lua
-- Gravel-related blocks for advtrains
--[[
    Copyright © 2011-2024 Hugo Locurcio and contributors.
    Licensed under the zlib license. See LICENSE.md for more information.
]]

local S = minetest.get_translator("train_gravels")

local sound_gravel = default.node_sound_gravel_defaults()

-- Gravel Stonebrick

minetest.register_node("train_gravels:gravel_stonebrick", {
    description = S("Gravel on Stonebrick"),
    tiles = {
        "default_gravel.png",
        "default_stone_brick.png",
        "default_gravel.png^[lowpart:50:default_stone_brick.png",
        "default_gravel.png^[lowpart:50:default_stone_brick.png",
        "default_gravel.png^[lowpart:50:default_stone_brick.png",
        "default_gravel.png^[lowpart:50:default_stone_brick.png"
    },
    groups = { cracky = 3 },
    sounds = sound_gravel,
})

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
        description = S("Gravel Slop @1", id),
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