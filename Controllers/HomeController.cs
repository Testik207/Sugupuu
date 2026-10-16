using Microsoft.AspNetCore.Mvc;

namespace Sugupuu.Controllers;

public class HomeController : Controller
{
    public IActionResult Index() => View();
    public IActionResult Teooria() => View();
    public IActionResult Kontakt() => View();
    public IActionResult XmlSkeem() => View();

    public IActionResult Sugupuu()
    {
        ViewData["Title"] = "Sugupuu";
        ViewData["XmlFail"] = "ElisavetaSugupuu.xml";
        ViewData["XslFail"] = "sugupuuParing.xslt";
        return View();
    }

    public IActionResult MinuSugupuu()
    {
        ViewData["Title"] = "Minu sugupuu";
        ViewData["XmlFail"] = "MinuSugupuu.xml";
        ViewData["XslFail"] = "minuSugupuuParing.xslt";
        return View("Sugupuu");
    }
}
