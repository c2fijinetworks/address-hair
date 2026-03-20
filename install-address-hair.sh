#!/bin/bash

# 1. Hardcode Logo Component (Removing SITE.name dependency)
cat << 'INNEREOF' > src/components/Logo.astro
---
---
<a href="/" class="flex items-center">
  <img src="/images/logo.webp" alt="Address.Hair" class="h-10 w-auto mr-2 rtl:mr-0 rtl:ml-2" loading="lazy" decoding="async">
  <span class="self-center text-2xl md:text-xl font-bold text-gray-900 whitespace-nowrap dark:text-white">
    Address.Hair
  </span>
</a>
INNEREOF

# 2. Hardcode Footer Component (Removing SITE.name dependency)
cat << 'INNEREOF' > src/components/widgets/Footer.astro
---
import { Icon } from 'astro-icon/components';
import { getHomePermalink } from '~/utils/permalinks';

interface Link { text?: string; href?: string; ariaLabel?: string; icon?: string; }
interface Links { title?: string; links: Array<Link>; }
export interface Props { links: Array<Links>; secondaryLinks: Array<Link>; socialLinks: Array<Link>; footNote?: string; theme?: string; }

const { socialLinks = [], secondaryLinks = [], links = [], footNote = '', theme = 'light' } = Astro.props;
---

<footer class:list={[{ dark: theme === 'dark' }, 'relative border-t border-gray-200 dark:border-slate-800 not-prose']}>
  <div class="relative max-w-7xl mx-auto px-4 sm:px-6">
    
    <!-- Top area: Centered Links -->
    <div class="flex justify-center py-8 md:py-12">
      {links.map(({ title, links: primaryLinks }) => (
        <div class="text-center">
          <div class="dark:text-gray-300 font-medium mb-2">{title}</div>
            <ul class="text-sm flex flex-wrap justify-center items-center" role="list">
                {primaryLinks.map((link, index) => (
                    <li>
                        <a class="text-muted hover:text-gray-700 hover:underline dark:text-gray-400 transition" href={link.href}>{link.text}</a>
                        {index < primaryLinks.length - 1 && <span class="mx-2" aria-hidden="true">·</span>}
                    </li>
                ))}
            </ul>
        </div>
      ))}
    </div>

    <!-- Bottom area -->
    <div class="flex flex-col-reverse items-center md:flex-row md:justify-between py-6 md:py-8 border-t border-gray-200 dark:border-slate-800">
      
      <!-- Left side: Hardcoded Address.Hair Brand -->
      <div class="text-sm text-muted text-center md:text-left mt-4 md:mt-0">
        <div class="font-bold text-lg mb-1">
          <a href={getHomePermalink()}>Address.Hair</a>
        </div>
        <div>
          <Fragment set:html={footNote} />
        </div>
      </div>

      <!-- Right side: Terms + Socials -->
      <div class="flex items-center justify-center gap-x-6">
        <div class="text-sm text-muted">
          {secondaryLinks.map(({ text, href }, index) => (
            <>
              <a class="text-muted hover:text-gray-700 dark:text-gray-400 hover:underline transition" href={href} set:html={text} />
              {index < secondaryLinks.length - 1 && <span class="px-1">·</span>}
            </>
          ))}
        </div>
      </div>
    </div>
  </div>
</footer>
INNEREOF

# 3. Aggressive recursive cleanup of any remaining "Schedule" strings in all files
find src -type f \( -name "*.astro" -o -name "*.md" -o -name "*.ts" -o -name "*.json" -o -name "*.yaml" \) -exec sed -i 's/schedule\.hair/address\.hair/g' {} +
find src -type f \( -name "*.astro" -o -name "*.md" -o -name "*.ts" -o -name "*.json" -o -name "*.yaml" \) -exec sed -i 's/Schedule\.Hair/Address\.Hair/g' {} +
find src -type f \( -name "*.astro" -o -name "*.md" -o -name "*.ts" -o -name "*.json" -o -name "*.yaml" \) -exec sed -i 's/Schedule Hair/Address\.Hair/g' {} +

# 4. Overwrite navigation.ts to ensure footer title is correct
cat << 'INNEREOF' > src/navigation.ts
import { getPermalink } from './utils/permalinks';

export const headerData = {
  links: [
    { text: 'Features', href: getPermalink('/#features') },
    { text: 'Process', href: getPermalink('/#process') },
    { text: 'The Story', href: getPermalink('/about') },
    { text: 'Pricing', href: getPermalink('/pricing') },
  ],
  actions: [
    { text: 'Claim Your URL', variant: 'primary', href: '/pricing' }
  ],
};

export const footerData = {
  links: [
    {
      title: 'Address.Hair',
      links: [
        { text: "Claim Your Site – $99", href: getPermalink('/pricing') },
        { text: 'The Story', href: getPermalink('/about') },
        { text: 'Support', href: getPermalink('/contact') },
      ],
    },
  ],
  secondaryLinks: [
    { text: 'Terms of Service', href: getPermalink('/terms') },
    { text: 'Privacy Policy', href: getPermalink('/privacy') },
  ],
  socialLinks: [],
  footNote: 'Address.Hair © 2026. All rights reserved.',
};
INNEREOF

# 5. Final Push
git add .
git commit -m "Final: Hardcoded Address.Hair in Footer and Logo to prevent Schedule Hair leaks"
git push

echo "----------------------------------------------------"
echo "✅ Address.Hair FOOTER FIXED"
echo "✅ Brand Name Hardcoded to bypass config leaks"
echo "✅ Global string replacement complete"
echo "----------------------------------------------------"
