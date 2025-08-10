# Codex Looter Shooter

## Overview
Codex Looter Shooter is a **2D multiplayer top-down looter shooter** where each character is built from 5 block segments representing their gear and body parts.  
Players explore large maps, loot better gear, and fight each other to survive and dominate.

## Character System
- Characters are made of **5 blocks**:
  1. **Head (H)**
  2. **Body (B)**
  3. **Legs (L)**
  4. **Hands (A)**
  5. **Weapon (W)**
- Each block’s **color** represents the **quality tier** of that gear (e.g. Common, Rare, Epic, Legendary).
- Each block has a **letter label**:
  - `H` = Head
  - `B` = Body
  - `L` = Legs
  - `A` = Hands
- `W` = Weapon

## Inventory
- Each gear slot maintains **5 inventory blocks** for spare equipment of that type.
- Players have an additional **5-slot backpack** for miscellaneous items.
- Items can be **equipped**, **stored**, or **dropped** back into the world.
- Dropped items have a **5 second pickup delay** before they can be collected again.

## Gear Quality System
Example color coding:
- **Grey** = Common
- **Green** = Uncommon
- **Blue** = Rare
- **Purple** = Epic
- **Gold** = Legendary

Gear stats affect:
- **Head:** Vision range / critical hit chance
- **Body:** Armor / health points
- **Legs:** Movement speed
- **Hands:** Reload speed / weapon handling
- **Weapon:** Damage / fire rate

## Gameplay Loop
1. **Spawn** in a large open map with random starting gear.
2. **Explore** the map to find loot crates and hidden areas.
3. **Upgrade gear** by replacing block parts with better-quality ones.
4. **Fight** other players using ranged weapons.
5. **Survive** and collect the best possible set before the match ends.

## Combat
- **2D top-down shooting mechanics** with mouse aiming.
- Weapons vary in **fire rate, damage, range, and reload time**.
- Players drop **some or all loot** upon death.

## Maps
- **Large and open** with mixed terrain (buildings, forests, open fields).
- Randomized loot spawns.
- Safe zones and high-loot risk areas.
- Support for multiple maps.

## Multiplayer
- **Online multiplayer** support.
- Player capacity: 10–20 per match.
- Lobby system with matchmaking.

## Technical Notes
- **Engine:** Godot or Unity 2D
- **Camera:** Top-down
- **Networking:** Real-time server-authoritative multiplayer
- **Assets:** Simple block sprites with color variants and letter markings

## Example Tasks for Codex
- Generate top-down movement controller.
- Create block-based character customization system.
- Implement loot spawning and item rarity system.
- Add multiplayer shooting mechanics with hit detection.
- Create HUD showing player’s equipped blocks and their stats.
- Implement death/respawn logic with loot drop.
