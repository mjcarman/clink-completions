@echo off
chcp 65001 1>nul
luacheck . && call busted
