pfUI:RegisterModule("sellvalue", function ()
  pfUI.sellvalue = CreateFrame( "Frame" , "pfUIsellvalue", GameTooltip )

  pfUI.sellvalue:SetScript("OnShow", function()
    if GetMouseFocus() and GetMouseFocus():GetParent() then
      local bag = GetMouseFocus():GetParent():GetID()
      local slot = GetMouseFocus():GetID()
      local _, count = GetContainerItemInfo(bag, slot)
      local itemLink = GetContainerItemLink(bag, slot);
      if not itemLink then return end

      local _, _, iid = string.find(itemLink, "item:(%d+):%d+:%d+:%d+")
      local _, _, itemLink = string.find(itemLink, "(item:%d+:%d+:%d+:%d+)");
      local itemName = GetItemInfo(itemLink)

      if pfSellData[tonumber(iid)] and itemName == getglobal("GameTooltipTextLeft1"):GetText() then
        local _, _, sell, buy = strfind(pfSellData[tonumber(iid)], "(.*),(.*)")
        sell = tonumber(sell)
        buy = tonumber(buy)

        if not MerchantFrame:IsShown() then
          if sell > 0 then SetTooltipMoney(GameTooltip, sell * count) end
        end

        if IsShiftKeyDown() or pfUI_config.tooltip.vendor.showalways == "1" then
          GameTooltip:AddLine(" ")

          if count > 1 then
            GameTooltip:AddDoubleLine("Sell:", pfUI.api.CreateGoldString(sell) .. "|cff555555  //  " .. pfUI.api.CreateGoldString(sell*count), 1, 1, 1);
          else
            GameTooltip:AddDoubleLine("Sell:", pfUI.api.CreateGoldString(sell * count), 1, 1, 1);
          end

          if count > 1 then
            GameTooltip:AddDoubleLine("Buy:", pfUI.api.CreateGoldString(buy) .. "|cff555555  //  " .. pfUI.api.CreateGoldString(buy*count), 1, 1, 1);
          else
            GameTooltip:AddDoubleLine("Buy:", pfUI.api.CreateGoldString(buy), 1, 1, 1);
          end
        end
        GameTooltip:Show()
      end
    end
  end)
end)
