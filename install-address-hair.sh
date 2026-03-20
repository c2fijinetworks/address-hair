#!/bin/bash

# 1. Aggressive Global Search and Replace for any remaining "Schedule" strings
# This handles the dot version, the space version, and the URL version across all source files.
find src -type f \( -name "*.astro" -o -name "*.md" -o -name "*.ts" -o -name "*.json" \) -exec sed -i 's/schedule\.hair/address\.hair/g' {} +
find src -type f \( -name "*.astro" -o -name "*.md" -o -name "*.ts" -o -name "*.json" \) -exec sed -i 's/Schedule\.Hair/Address\.Hair/g' {} +
find src -type f \( -name "*.astro" -o -name "*.md" -o -name "*.ts" -o -name "*.json" \) -exec sed -i 's/Schedule Hair/Address\.Hair/g' {} +

# 2. Force Overwrite Footer & Navigation for consistency
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

# 3. Explicitly fix Logo component
sed -i 's/SITE?.name/ "Address.Hair" /g' src/components/Logo.astro

# 4. Fix Pricing Page FAQ (Restoring the 4th block for a complete grid)
cat << 'INNEREOF' > src/pages/pricing.astro
---
import Layout from '~/layouts/PageLayout.astro';
import HeroText from '~/components/widgets/HeroText.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import FAQs from '~/components/widgets/FAQs.astro';
import Features3 from '~/components/widgets/Features3.astro';
import { lifetimeDeal } from '~/data/pricingData';

const metadata = { 
  title: 'Pricing | Secure Your Address.Hair URL', 
  description: 'Professional salon vanity URLs with zero monthly fees. One-time setup, lifetime presence, live in hours.' 
};
---
<Layout metadata={metadata}>
  <HeroText 
    tagline="The Professional Standard"
    title="Claim Your Name Before Someone Else Does." 
    subtitle="Your vanity URL is your digital storefront. Don't let your competition secure your salon's name. For a one-time fee of $99, we build your boutique homepage and get you live on address.hair/yoursalon before your last appointment of the day."
  />

  <Pricing prices={[lifetimeDeal]} />

  <Features3
    title="Why Stylists are Switching to Address.Hair"
    subtitle="We move you beyond the generic 'Bio Link' and into a professional digital asset."
    columns={3}
    items={[
      { 
        title: 'The Vanity URL Advantage', 
        description: 'Ditch the long, messy booking IDs. Own a professional address (address.hair/yoursalon) that is easy for clients to type, remember, and share via text or DM. It signals elite status instantly.', 
        icon: 'tabler:link' 
      },
      { 
        title: 'Same-Day White-Glove Setup', 
        description: 'We don’t make you wait weeks. If you order by 2PM, our team builds your site, syncs your Instagram portfolio, and deploys your URL today. You focus on the hair; we handle the code.', 
        icon: 'tabler:bolt' 
      },
      { 
        title: 'Eliminate the "SaaS Tax"', 
        description: 'Stop paying $50-$150 every month just to have a website. Our $99 one-time license gives you lifetime hosting, security, and updates. That is $600+ back in your pocket every single year.', 
        icon: 'tabler:coin' 
      },
      { 
        title: 'Google Profile Authority', 
        description: 'Boost your Local SEO by linking your vanity URL to the "Website" button on Google. Professional domains carry more weight than generic social links, helping you climb the rankings.', 
        icon: 'tabler:brand-google' 
      },
      { 
        title: 'Zero Maintenance Sync', 
        description: 'Your time belongs behind the chair. Our system automatically refreshes your website content every time you post to Instagram. Your latest work is always front and center.', 
        icon: 'tabler:refresh' 
      },
      { 
        title: 'Mobile-First Luxury', 
        description: '90% of your clients book on their phones. We build for speed and aesthetic perfection on iPhone and Android, ensuring a premium experience from the very first click.', 
        icon: 'tabler:device-mobile' 
      },
    ]}
  />

  <FAQs
    title="Pricing & Setup Questions"
    items={[
        { 
          title: 'Is it really just one payment?', 
          description: 'Yes. We charge a one-time setup and licensing fee. We believe salon owners are over-subscribed, so we eliminated the monthly bill. You get the website, the vanity URL, the Instagram sync, and the hosting for life.', 
          icon: 'tabler:coin' 
        },
        { 
          title: 'Can I use my own .com domain?', 
          description: 'Absolutely. While the free Address.Hair vanity URL is included, we can fully set up and manage your own custom .com or .salon domain for just $15/year. We handle all the tech and pointing for you.', 
          icon: 'tabler:world' 
        },
        { 
          title: 'How does the "Same-Day" setup work?', 
          description: 'Our team monitors orders in real-time. Once you secure your license, we send a brief form to grab your Instagram handle and basic details. If you complete that by 2PM EST, we guarantee your site will be live before the end of the business day.', 
          icon: 'tabler:bolt' 
        },
        { 
          title: 'What if I need help after setup?', 
          description: 'Our white-glove support doesn\'t end at launch. If you change your salon name, want to tweak your brand colors, or need help updating your Google profile, our team is available to assist via our support desk.', 
          icon: 'tabler:headset' 
        },
    ]}
  />
</Layout>
INNEREOF

# 5. Fix Legal Pages (Contact Links)
# Terms
cat << 'INNEREOF' > src/pages/terms.md
---
layout: '~/layouts/MarkdownLayout.astro'
title: 'Terms of Service'
---

Last updated: March 20, 2026

Welcome to **Address.Hair**. By using our services, you agree to these terms. Please read them carefully.

### 1. Services
Address.Hair provides vanity URLs and salon homepage hosting services. Our lifetime deal includes setup, hosting, and social media synchronization for a one-time fee.

### 2. Fees and Payments
All payments are one-time fees as specified at the time of purchase. There are no recurring monthly subscriptions for our standard hosting and vanity URL package. Custom domain renewals (.com, .salon, etc.) are billed annually.

### 3. Content
You retain all rights to the content synced from your social media accounts. You grant Address.Hair a license to display that content on your provided vanity URL.

### 4. Termination
We reserve the right to suspend or terminate services for accounts that violate local laws or engage in fraudulent activity.

### 5. Contact
If you have any questions about these Terms, please contact us at [https://address.hair/contact](https://address.hair/contact).
INNEREOF

# Privacy
cat << 'INNEREOF' > src/pages/privacy.md
---
layout: '~/layouts/MarkdownLayout.astro'
title: 'Privacy Policy'
---

Last updated: March 20, 2026

At **Address.Hair**, we value your privacy.

### 1. Information We Collect
We collect your name, email address, and salon business details when you purchase a license. We also access public Instagram data via authorized APIs to synchronize your homepage gallery.

### 2. How We Use Information
We use your information to set up your digital address, provide tech support, and notify you of system updates. We do not sell your data to third-party advertisers.

### 3. Data Security
We implement standard industry security measures to protect your account details and payment information.

### 4. Contact Us
If you have questions about your data, please visit [https://address.hair/contact](https://address.hair/contact).
INNEREOF

# 6. Final Push
git add .
git commit -m "Fix: Final branding cleanup, fixed 4th Pricing FAQ block, and updated legal contact links"
git push

echo "----------------------------------------------------"
echo "✅ Address.Hair FINAL POLISH DEPLOYED"
echo "✅ 4 Pricing FAQs now showing"
echo "✅ Terms & Privacy contact links fixed"
echo "✅ Global Schedule Hair removal complete"
echo "----------------------------------------------------"
