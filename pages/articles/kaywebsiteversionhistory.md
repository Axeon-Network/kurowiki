---
title: KayWebsite version history
permalink: KayWebsite_version_history
redirect_from:
aliases:
hatnote: Main article&#58; <a href='KayWebsite'>KayWebsite</a>
---
This is a list of all released versions of KayWebsite and their changelogs, as of 30 October 2025, from latest to earliest. This list only includes v2.x and v3.x versions at the moment, and is subject to change as new KayWebsite versions come out.

The changelogs of all versions before and including v3.3.1 are inherited from KayWebsite's changelog page, which was deprecated as of November 2025. They've been all archived here for historical purposes.

# Version 25.x
## 25.11.2
Released on 29 November 2025, it mainly updated the Projects and Devices pages. Other changes include fixing issues and inconsistencies in the CSS styling, while the automated CI/CD version determination was updated to exclude unnecessary version bumps in the event of new blog posts or edits of them, unless they come "in package" with changes to the website itself.

## 25.11.1
Released on 19 November 2025, the main change is the fact the 88x31 buttons section in the homepage is now a collapsible box, closed by default. This is to make the homepage look cleaner.

## 25.11
Released on 6 November 2025, it brings various bug fixes and improvements. In particular, the general font size was increased in the Retro Frontend for better readability, while the font sizes of several elements of the main website were adjusted for consistency with respect to the general font size that was increased in the previous version.

Broken links and issues with the CI/CD version determination were also fixed, while soft breaks are now properly supported in Markdown without the need to append an `\` character at the end.

## 25.10
The first version to use the new date versioning system in the vYY.M.R format (where YY means the year of release, M means the month of release, and R the revision number for the month), it was released on 30 October 2025. Under this new version scheme, the version is automatically determined through CI/CD on GitHub every time KayWebsite is built in production.

This KayWebsite release changed the sitewide font from Inter to Atkinson Hyperlegible and increased font size. The Devices page was also overhauled, while embeds were fixed and now display properly. On the backend side, page headings and descriptions are now declared as Astro props.

The plaintext mode warning (i.e. when no CSS is loaded, for example on browsers lacking proper CSS support like Netscape 4) was updated to properly specify that it is not explicitly supported.

# Version 3.x
## 3.3.1
This version was released on 7 October 2025. It is the final KayWebsite version to use the Semantic Versioning (SemVer) system, as the next version would jump from major version 3 to major version 25 (for the then-current year 2025) as part of the switch to a new date versioning system in the year-month-revision format (vYY.M.R). As such, this is considered the final v3 release of KayWebsite.

* **Projects**: Updated projects.
* **Devices**: Minor fix.
* Deprecated `/discord` redirect first introduced in v2.5.2, in favor of the same redirect from AxeonWebsite.

## 3.3
This version was released on 14 September 2025.

* **Added a Tags page**, listing all tags used in blog posts. This completes the implementation of tags first added in v2.5.
* **Home**: Added a link to the **Devices page**, added more fun wording and reworded the natural sights sentence.
* **Home**: Added two new 88x31 buttons and removed one that became irrelevant over time.
* **Projects**: Updated projects.
* **Devices**: Added more details on specs of other PCs.
* The website colors and logos have been **changed to correspond with the current KayAurora branding**.
* Reduced general `font-size` **on mobile**.
* The font used in headings on the website is now **uniformly applied everywhere, including in the blog**.
* **Retro Frontend**: The margins on the side of the page content are **no longer being rendered**.
* Reduced the amount of stars displayed **on the mobile navbar**.
* The change from **relative to absolute URLs for images in blog posts** (v3.0.1) has been reverted. A solution has been found to keep rather relative URLs while bypassing Astro's "image optimization".
* **RSS Feed**: Fixed small text in blog posts not being parsed correctly.
* Fixed an issue where **some links' outlines may become thinner** once the hover animation finishes.
* Timezones sitewide **are now in UTC instead of GMT**.
* `tzname` (previously removed from homepage in v3.2.2) is no longer supported as a configurable variable in `config.ts`
* Bumped dependencies.

## 3.2.2
This minor version was released on 28 August 2025 and introduced small changes.
* **Devices**: Correction on main PC specs
* **Home**: Removed timezone name; only display the offset

## 3.2.1
This minor version was released on 15 August 2025, primarily as part of the domain migration, but also fixed and refined other aspects of the website.
* Reflect on recent domain change from **clyron.is-a.dev** to **kay.is-a.dev**.
* **Devices**: Slight design refinements.
* Fixed lack of padding in subheadings/section titles.
* **Retro Frontend**: `font-size` of the navbar no longer increases **in browsers that support the CSS property**.

## 3.2
This version was released on 11 August 2025.
      
* **Added a Devices page**, including a list of devices I (Kay) own as well as PC Specs.
* **Blog**: Fixed padding of the RSS button in the modern frontend.
* **Changelog page**: Fixed margins in the text of the changelogs.
* **Home**: The message for copying the HTML code of 88x31 buttons is now **always loaded with JavaScript**.
* **Projects**: Reflect on current status of projects to date.
* Removed the `content.config.ts` file due to it not being actually used.
* Slight CSS code cleanup.

## 3.1
This version was released on 24 July 2025 and introduced the full Retro Frontend.

* **A new Retro Frontend has replaced the normal website layout** in browsers that do not support the CSS `@supports` rule (i.e. older browsers). A further plaintext fallback has been thrown up together as well for browsers with limited to no CSS support.
* Updated **FontAwesome to version v7!** This fixes the text alignment issue in the Socials page.
* **Home**: Slight rewording of introduction/biography. Also, added an additional 88x31 button to the Buttons section.
* **Pronouns and timezone** are now configurable variables in `config.ts`.

## 3.0.1
This version released on 19 July 2025.
      
* Added **additional fallbacks for ancient browsers** in `style.css`, with `rem` values falling back to `px` and the inclusion of `background-color` as an alternative to the gradient.
* Images in the blog now all use **absolute instead of relative URLs**. Astro v5 automatically ""optimizes images"" with relative URLs in markdown **and converts them to WebP**, only supported in modern browsers, with no way to easily prevent it :(

## 3.0
This major version released on 18 July 2025. This is the first version of the website to refer to itself as KayWebsite and not include Tailwind CSS.

* **Completely ditched Tailwind CSS**, thus regaining full control over the CSS looking forward **to eventual ancient browser support**. Support is currently guaranteed as low as IE11.
* **The website has received a visual overhaul!** This incorporates the design of the current branding while making it more aesthetically pleasing, also adding various animations.
* The Cairo (`/cairo`) page has been **removed**, to reduce maintenance burden. The OC had no longer been used with no plans to bring it back.
* **Home**: 88x31 buttons have been moved into their own Astro Component. Also, clicking on the Kay 88x31 buttons now automatically **copies their corresponding HTML codes to the clipboard!**
* **Home**: Introduction/biography has been rewritten to be more brief.
* **Blog**: The Lynxmic Blog button has been removed. It will however continue to be accessible at `/lynxblog`
* **Blog**: Tags now have a fallback display for ancient browsers
* The Cards component has been removed. The Projects and Socials pages have been **rewritten in list view**.
* The LegacyBrowsers component has been removed. This was supposed to **redirect ancient browsers to ClyronWebsite v1.x**.
* Added support for **favicon** as a separate adjustable variable from the logo in `config.ts`.
* *Layout.astro* and *BlogPostLayout.astro* have been renamed *Site.astro* and *Blog.astro* respectively.
* **Moved noscript warning** from the navbar to the footer.
* General code cleanup & bumped dependencies.

# Version 2.x

## 2.5.2
This version released on 8 July 2025. It is the last version of the website under the name of ClyronWebsite, the last version of v2.x, and the last version to include Tailwind CSS.
      
* Changed all Clyron references to **KayAurora**. Clyron is now being referred to as a previous alias, but the website **remains at clyron.is-a.dev for now.**
* Added new **88x31 buttons**. The Clyron button has been replaced with primary and alternate Kay ones.
* Added a `/discord` redirect page, leading to **Axeon Network**.
* **Home**: Changed timezone shown in introduction.

## 2.5.1
This version released on 4 July 2025. It is the last version of the website to include any references to Clyron, as the next version would start referring to [KayAurora](KayAurora) as 'KayAurora'.

* **Cairo page**: Updated Reference Sheet to include a drawing of Cairo **with glasses on**.
*  Added support for **shorter forms of names** and **FontAwesome versions** as adjustable variables in `config.ts`.
* **Home**: Updated introduction to reflect on Lynxmic hitting 1,5K subs and mention Axeon's member count.
Pojects
* **Home**: On par with other 88x31 buttons in use, the Clyron button now **renders pixelated** and uses **relative instead of absolute URL**.
 * **Socials**: Updated YouTube name.
* Bumped dependencies.

## 2.5
This version released on 3 July 2025 and included lots of changes.
      
* **Tags have been implemented** in the blog! All blog posts have been retroactively applied tags.
* Added a **footer**, including information like copyright, licensing and a link to this page.
* Content no longer live inside a box **on small and medium form factors**, making it better and more enjoyable to view on phone or tablet screens.
 * **Blog post headers** have been redesigned and are now more consistent with those of the rest of the site.
*  Added more proper fade animations upon **accessing the website** and transitioning between pages.
*  **On Firefox/Gecko**, the fade and gradient animations are disabled at least for the time being. <small>(will try to find a solution eventually to have them properly render)</small>
* **Cairo page**: Added Reference Sheet and a notice that the OC is no longer being used.
* **Home**: Slightly rearranged 88x31 buttons. Plus, they now actually display properly on small form factors with bigger width size.
* **Projects**: Split into two separate sections for active and past projects. Also reflect on Lynxmic hitting 1,5K subs.
* **Socials**: Improved wording in some areas for more easier understanding.
* **Blog index**: Relocated the *View older blog posts* button on the top, next to the RSS button.
* **Changelog page**: Added all previous v2.x versions' changelogs.
* Fixed an issue where images in blog posts would **not load when using an RSS reader**.
* Fixed an issue in blog posts where images were **weirdly stretching or overflowing** on bigger form factors.
* Fixed the title of the changelog page still displaying as "*Home*".
* Fixed an issue where the gradient animation **would reset** when switching between pages.
* A `config.ts` file has been created, including variables used for easier code management.
* In `style.css`, all colors are now consistently defined using RGB(A) instead of Hex color code.
* General file structure cleanup.

## 2.4.2
This version released on 5 June 2025

* Changed the Clyron logo from the ring previously used to the newly-introduced glowing star logo.
* **Home**: The biography section now mentions Axeon Network.

## 2.4.1
This version released on 2 June 2025
      
* Updated an outdated link in the **Projects** page.
* **Cairo page**: Adjusted formatting and updated the OC's (fictional) residence.

## 2.4
This version released on 25 May 2025
      
* Added the **Changelog** (`/cl`) page <small>(the page you're currently looking at!)</small>, tracking version history and changes.
* The navbar is now an **Astro Component**, allowing for easier code maintenance. The JavaScript check has been moved inside the component as well.
* Removed the **Retro Site** button from homepage. An eventual Retro Frontend will be built on top of clyronwebsite instead of a separate one, for easier maintenance
* The **Visit Homepage** button has been removed from the 404 page. Unnecessary, as the navbar exists
* Updated introduction in homepage. Now specifing just Minecraft as my (Clyron's) "all-time favorite game". Also removed the Cairo line, as the OC is no longer being used. The page continues to be available though.
* Navbar items and webring names are now **bold**.
* Readjusted order in the Socials page. Geometry Dash is now last.
* Fixed a typo in a CSS class for the blog posts.

## 2.3.1
This version released on 30 April 2025

* **Socials**: Mentions of **LynxPlaza** have been changed to **Axeon Network**, the new name of the Discord server.
* **Home**: Added a tooltip to the **Retro Site** button, explaining that an eventual Retro Frontend is coming soon.
* Slight code cleanup by removing unused CSS classes.

## 2.3
This major version released on 26 April 2025
      
* **Redesigned the navigation bar**. Removed the *I am just a semi-average internet user~* line and moved links outside the box.
* Adjusted the **gradient colors** to reflect the Clyron branding in use at this time.
* Changed the website font from **Asap** <small>(the Lynxmic font!)</small> **to Inter**.
* Transitioning between pages in the website **is now smoother**, thanks to `astro:transitions`.
* The page width **has been adjusted** in consistency with the blog view.
* The `Greeting.astro` component (including seasonal greeting messages in the homepage) has been **removed**.
* The **Buttons** (`/buttons`) page has been entirely **removed**, in favor of the homepage 88x31 button section.
* The `/kairo` redirect to `/cairo` has been **removed**.
* **404 page**: General overhaul.
* **Home**: The **Legacy Site** button has been changed to a **Retro Site** button, that will eventually go to **a new Retro Frontend**.
* **Blog index**: The RSS feed link has been **changed to a button**. Also, the legacy Lynxmic Blog button has been **changed for consistency** with the homepage's Retro Site button.
* **Socials**: Do no longer refer to **LynxPlaza as the Lynxmic Discord server**. Also added DeviantArt, removed Akkoma and adjusted some wordings.
* **Cairo page**: Improved wording when explaining if the Cairo OC wears glasses.
* Added `rel` as a prop in the **Cards** Astro component. This makes possible verifying with Mastodon etc.
* Blog posts no longer use `prose-invert`, instead defining custom colors for normal `prose` **via Tailwind's config file**.

## 2.2.1
This version released on 31 March 2025.
      
* **Cairo page**: Updated Cairo profile picture and optimized page for mobile.
* **Home**: Fix 88x31 buttons not displaying properly on mobile.
* Use relative instead of absolute URLs for the logo, and move it inside the `/img` directory.

## 2.2
This version released on 30 March 2025.
      
* **Cairo page**: Renamed from **Kairo to Cairo**, updated the body drawing to remove glasses, added profile picture and other additional basic info and lore.
* As a result **of the above renaming**, the `/kairo` page now redirects to `/cairo`. This redirect will stay until the next major website version.
* On old/legacy browsers, the website now **automatically redirects** to clyronwebsite v1 as a fallback.
* **Home**: Added a **Legacy Site button**, leading to clyronwebsite v1.
* **Home**: Added additional 88x31 buttons and updated introduction.

## 2.1
This version released on 19 March 2025.
      
* Added a new page for **the new Clyron OC**, called **Kairo**, and updated introduction in homepage to mention it.
* **Home**: Added 88x31 buttons and webrings (Fediring).
* **Blog index**: Removed **all pre-Clyron blog posts** in favor of a button leading to the legacy Lynxmic Blog.
* **Buttons**: Include the Lynxmic 88x31 button as part of a new **Project buttons** section.
* **Socials**: Adjusted list to be in order of activity.
* Custom, non-Tailwind CSS code **has been moved** into a separate `style.css` file from the layout files.

## 2.0.1
This version released on 3 March 2025.
      
* Updated **the Clyron 88x31 button** and added a Lynxmic 88x31 button in the website's files.
* **Socials**: Removed Revolt.

## 2.0
This version released on 9 February 2025. It is the first stable release of v2, replacing the Win2K-style v1.

* Added the **RSS feed!**
* **Blog index**: Sort blog posts from latest to oldest, not otherwise.
* The Astro Component associated with the seasonal snowflake effects **has been removed**.

## 2.0-beta080225
This version released on 8 February 2025. It is the final beta release of v2.0.
      
* Improvements to readability of blog posts.
* Slight backend changes, mainly **in preparation for the RSS feed**.

## 2.0-beta070225
This beta version released on 7 February 2025.
      
* **Home**: Added a quick introduction/biography.
* The seasonal snowflake effects **no longer display** on the website.
* Removed mentions of "Public Beta" and "Under Construction", as well as the public beta version **in preparation for the final release**.
* Slight cleanup in several pages.

## 2.0-beta030225
This beta version released on 3 February 2025. It changed the version numbering scheme of public betas to include date in the DDMMYY format.

* **Socials**: Added Revolt. Also, replaced the link to the actual Twitter account with the archive of it.
* Fixed **broken links** in blog posts.
* The `Card.astro` component **now supports buttons** through the `btn_href` and `btn_action` props, replacing `href`.
* Slight cleanup in several pages.

## 2.0-beta4
This beta version released on 18 January 2025.
      
* Added an **initial implementation of the blog!** Posts from the v1 website have been ported there.
* Added a **Buttons** (`/buttons`) page, listing self-created 88x31 buttons.
* Bumped package versions. Most notably, migrated from Astro **v4 to v5**.

## 2.0-beta3
This beta version released on 15 January 2025, just shortly after the previous version.
      
* Proper **optimization for small form factors!** (e.g. phone and tablet screens)
* **Blog index**: Added a link to the website v1 blog as a fallback, for until the actual blog is ready.
* Added emojis to **page titles** for a more fun look.

## 2.0-beta2
This beta version released on 15 January 2025.
      
* The background has been changed **to an animated gradient**, and the font size has been adjusted to be larger.
* The page width has **been adjusted** for more space on the sides.
* The main content box is now **rounded**.
* The cards seen in the Projects and Socials pages **have been migrated** to an Astro Component.
* **Socials**: Fixed a grammatical issue. Also, Twitter is now being referred to as *just* Twitter, without acknowledging "X" as its name.
* The website now **displays the public beta version**, alongside the "Under Construction" line.

## 2.0-beta1
This beta version released on 11 January 2025. It is the first ever public release of website v2.x. The changelog below includes differences between this version and the final version of v1.x.
      
* This rewritten website **uses Astro and Tailwind CSS**, instead of Jekyll and pure CSS.
* This website replaces the retro Win2K-style found in the v1 website **with a simpler design**, with logo, navbar, and a simple content box, along with the *I am just a semi-average internet user~* line.
* Projects and Socials **have been split** in their own pages, separate from the homepage. 

