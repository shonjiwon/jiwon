package kr.go.songpa.ssem.model;

import java.io.Serializable;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-13
 * Description :
 * History :
 * Version :
 */
public class MenuMstVo implements Serializable {

    private static final long serialVersionUID = 2563992476570056636L;

    private MenuVo topMenu = null;
    private MenuVo subMenu = null;
    private MenuVo currentMenu = null;
    private List<MenuVo> topMenuList = null;
    private List<MenuVo> subMenuList = null;
    private int menuDept = 0;
    private int menuSubDept = 0;
    private String name = "";
    private String ret_url = "";
    private String child_url = "";

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public MenuVo getTopMenu() {
        return topMenu;
    }

    public void setTopMenu(MenuVo topMenu) {
        this.topMenu = topMenu;
    }

    public MenuVo getSubMenu() {
        return subMenu;
    }

    public void setSubMenu(MenuVo subMenu) {
        this.subMenu = subMenu;
    }

    public MenuVo getCurrentMenu() {
        return currentMenu;
    }

    public void setCurrentMenu(MenuVo currentMenu) {
        this.currentMenu = currentMenu;
    }

    public List<MenuVo> getTopMenuList() {
        return topMenuList;
    }

    public void setTopMenuList(List<MenuVo> topMenuList) {
        this.topMenuList = topMenuList;
    }

    public List<MenuVo> getSubMenuList() {
        return subMenuList;
    }

    public void setSubMenuList(List<MenuVo> subMenuList) {
        this.subMenuList = subMenuList;
    }

    public int getMenuDept() {
        return menuDept;
    }

    public void setMenuDept(int menuDept) {
        this.menuDept = menuDept;
    }

    public int getMenuSubDept() {
        return menuSubDept;
    }

    public void setMenuSubDept(int menuSubDept) {
        this.menuSubDept = menuSubDept;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRet_url() {
        return ret_url;
    }

    public void setRet_url(String ret_url) {
        this.ret_url = ret_url;
    }

    public String getChild_url() {
        return child_url;
    }

    public void setChild_url(String child_url) {
        this.child_url = child_url;
    }
}
