#!/bin/bash

# 1. Update Navigation.ts with Slogan in the Links Section
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
      title: 'Address.Hair | Digital Artistry ✂️',
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
  footNote: '© 2026. All rights reserved.',
};
INNEREOF

# 2. Update Footer.astro with Slogan and Emoji at the Bottom
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
          <div class="dark:text-gray-300 font-bold mb-2 uppercase tracking-widest text-sm">{title}</div>
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
      
      <!-- Left side: Brand + Nice Slogan -->
      <div class="text-sm text-muted text-center md:text-left mt-4 md:mt-0">
        <div class="mb-1">
          <a class="font-bold text-xl hover:text-primary transition" href={getHomePermalink()}>Address.Hair</a>
          <span class="hidden md:inline mx-2 text-gray-400">|</span>
          <span class="italic text-gray-500">Your Digital Masterpiece ✨</span>
        </div>
        <div>
          <Fragment set:html={footNote} />
        </div>
      </div>

      <!-- Right side: Terms -->
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

# 3. Execution: Git Push
git add .
git commit -m "UI: Added slogan and emoji to footer"
git push

echo "----------------------------------------------------"
echo "✅ Footer Updated with Slogan: Your Digital Masterpiece ✨"
echo "✅ Centered Link Title Updated: Address.Hair | Digital Artistry ✂️"
echo "✅ Changes Pushed to Cloudflare"
echo "----------------------------------------------------"
