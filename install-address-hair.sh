#!/bin/bash

# 1. Update Navigation
cat << 'INNEREOF' > src/navigation.ts
import { getPermalink } from './utils/permalinks';

export const headerData = {
  links: [
    { text: 'Features', href: getPermalink('/#features') },
    { text: 'Process', href: getPermalink('/#process') },
    { text: 'The Story', href: getPermalink('/about') },
    { text: 'Get Started', href: getPermalink('/pricing') },
  ],
  actions: [
    { text: 'Claim Your URL', variant: 'primary', href: '/pricing' }
  ],
};

export const footerData = {
  links: [
    {
      title: 'SalonWeb',
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
  footNote: 'SalonWeb. © 2026 Address.Hair. All rights reserved.',
};
INNEREOF

# 2. Update Pricing Data
cat << 'INNEREOF' > src/data/pricingData.ts
export const lifetimeDeal = {
  title: 'Salon Homepage Plan',
  subtitle: 'Boutique Websites for Stylists',
  price: 99,
  period: 'One-time payment',
  items: [
    { description: 'Premium Vanity URL (address.hair/yoursalon)' },
    { description: 'Real-time Instagram Content Sync' },
    { description: 'Aesthetic Boutique Design' },
    { description: 'Mobile-First User Experience' },
    { description: 'Integrated Booking Links' },
    { description: 'Zero Maintenance / No Monthly Fees' },
    { description: 'Same Day Setup Guaranteed' },
  ],
  callToAction: { target: '_blank' as const, text: 'Claim Your Salon\'s Website', href: '#', variant: 'success' },
};
INNEREOF

# 3. Update Homepage (index.astro) - FIXING ICON HERE
cat << 'INNEREOF' > src/pages/index.astro
---
import Layout from '~/layouts/PageLayout.astro';
import Header from '~/components/widgets/Header.astro';
import Hero2 from '~/components/widgets/Hero2.astro';
import Features from '~/components/widgets/Features.astro';
import Steps2 from '~/components/widgets/Steps2.astro';
import Content from '~/components/widgets/Content.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import { headerData } from '~/navigation';
import FAQs from '~/components/widgets/FAQs.astro';
import { lifetimeDeal } from '~/data/pricingData';

const metadata = { 
  title: 'Address.Hair | Boutique Websites for Stylists', 
  description: 'Your Salon Deserves a Digital Masterpiece. Elegant, high-converting websites with Instagram sync and vanity URLs.' 
};
---
<Layout metadata={metadata}>
  <Fragment slot="header"><Header {...headerData} isSticky /></Fragment>
  
  <Hero2
    tagline="Boutique Websites for Stylists"
    title='<span class="text-accent dark:text-white">Your Salon Deserves a Digital Masterpiece.</span>'
    subtitle="We build and deploy elegant, high-converting websites that sync with your social media, so you can focus on making your clients look beautiful."
    actions={[{ variant: 'primary', text: 'Claim Your Salon\'s Website', href: '/pricing/' }, { text: 'Features', href: '#features' }]}
    image={{ src: '/images/hero-poster.webp', width: 1024, height: 576 }}
  />

  <Features
    id="features"
    title="Everything Your Salon Needs"
    subtitle="Aesthetic Design: A Custom, high-end layout that mirror the luxury and vibe of your physical salon space."
    items={[
        { title: 'Aesthetic Design', description: 'Custom layouts that reflect the luxury and vibe of your salon.', icon: 'tabler:palette' },
        { title: 'Automated Social Feeds', description: 'We sync your Instagram directly to your site. Fresh content, zero effort.', icon: 'tabler:brand-instagram' },
        { title: 'Essential Business Info', description: 'Integrated booking links, clear location maps, and up-to-date hours.', icon: 'tabler:info-circle' },
        { title: 'Professional Hosting', description: 'Custom Vanity domains and lightning-fast hosting included.', icon: 'tabler:cloud-computing' },
    ]}
  />

  <Content
    isReversed
    tagline="Always Fresh. Zero Maintenance."
    title="Your site stays as fresh as your latest client's blowout."
    items={[
        { title: 'Real-time Instagram Sync', description: 'Your portfolio updates automatically every time you post a new transformation.', icon: 'tabler:refresh' },
        { title: 'Automatic Content Refresh', description: 'No more outdated websites. Your latest work is always front and center.', icon: 'tabler:camera' },
    ]}
    image={{ src: '/images/testimonial-2.webp', alt: 'Stylist working on a client' }}
  >
    <Fragment slot="content">
      <h3 class="text-2xl font-bold tracking-tight dark:text-white sm:text-3xl mb-2">
        <span class="text-accent dark:text-white">Real-time Instagram Sync</span>
      </h3>
      <p>Your website shouldn't be a chore. We automatically sync your latest Instagram posts directly to your homepage.</p>
    </Fragment>
  </Content>

  <div id="process" class="scroll-mt-20">
    <Steps2
      title="The Path to a Better Presence"
      subtitle="Three simple steps to your new digital home."
      items={[
        { title: '01. Sign up with your salon\'s brand', description: 'Secure your brand and choose your vanity URL.', icon: 'tabler:number-1' },
        { title: '02. We Build & Sync immediately', description: 'Our studio crafts your site and connects your social feeds for auto-updates.', icon: 'tabler:number-2' },
        { title: '03. Launch & Shine', description: 'Go live on address.hair/mysalonname and start attracting high-value clients.', icon: 'tabler:number-3' },
      ]}
      image={{ src: '/images/testimonial-6.webp', alt: 'Address Hair process' }}
    />
  </div>

  <Pricing title='Ready to elevate your salon’s brand?' prices={[lifetimeDeal]} />

  <FAQs
    title="Frequently Asked Questions"
    items={[
        { title: 'What is the Address.Hair Concept?', description: 'It is a boutique web presence that focuses on vanity URLs and automated content so you never have to "update" your website again.', icon: 'tabler:help' },
        { title: 'No technical skills required?', description: 'Correct. We handle everything. If you can print a piece of paper or post a photo, you can use this.', icon: 'tabler:tool' },
        { title: 'Is it really same day setup?', description: 'Yes. Order by 2PM and we usually have your vanity URL live before you close.', icon: 'tabler:bolt' },
    ]}
  />
</Layout>
INNEREOF

# 4. Update About Page
cat << 'INNEREOF' > src/pages/about.astro
---
import Hero2 from '~/components/widgets/Hero2.astro';
import Content from '~/components/widgets/Content.astro';
import Layout from '~/layouts/PageLayout.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import { lifetimeDeal } from '~/data/pricingData';

const metadata = { 
  title: 'The Story | Address.Hair', 
  description: 'Boutique websites for the world’s best stylists.' 
};
---
<Layout metadata={metadata}>
  <Hero2
    tagline="The Story"
    title='Boutique Websites for <span class="text-accent">Stylists</span>'
    subtitle="We believe your digital address should be as beautiful as the hair you style. We bridge the gap between your artistry and your online presence."
    actions={[{ variant: 'primary', text: 'Secure My Address', href: '/pricing/' }]}
    image={{ src: '/images/hero-poster.webp', alt: 'Address.Hair Professional Branding' }}
  />
  
  <Content
    items={[
        { title: 'Mirror Your Luxury', description: 'Your website should mirror the luxury and vibe of your physical salon space.', icon: 'tabler:award' },
        { title: 'Focus on Artistry', description: 'We handle the tech so you can focus on making your clients look beautiful.', icon: 'tabler:brush' },
    ]}
  >
    <Fragment slot="content">
      <h3 class="text-3xl font-bold mb-4">Professionalism: Beyond the Generic</h3>
      <p class="text-lg text-muted">Address.Hair provides the polish your brand deserves with zero maintenance required from you.</p>
    </Fragment>
    <Fragment slot="image">
       <img src="/images/testimonial-4.webp" alt="Elite salon styling" class="rounded-lg shadow-xl w-full" />
    </Fragment>
  </Content>
  <Pricing title="Ready to Own Your Professional Identity?" prices={[lifetimeDeal]} />
</Layout>
INNEREOF

# 5. Update Announcement Bar
cat << 'INNEREOF' > src/components/widgets/Announcement.astro
<div class="dark text-sm bg-black hidden md:flex items-center justify-center overflow-hidden px-3 py-2 relative text-ellipsis whitespace-nowrap">
  <div class="flex items-center gap-2">
    <span>✨ </span><span class="text-white font-medium">Claim your professional <strong>address.hair/mysalonname</strong> vanity URL today.</span>
  </div>
  <div class="absolute right-4 top-0 h-full flex items-center"><span class="text-white font-medium">Same-day setup. Just $99</span></div>
</div>
INNEREOF

# 6. Update Sticky Footer
cat << 'INNEREOF' > src/components/widgets/StickyFooterCTA.astro
---
import Button from '~/components/ui/Button.astro';
---
<div class="sticky bottom-0 z-40 w-full flex-none">
  <div class="bg-white dark:bg-slate-900 border-t dark:border-slate-800 shadow-t-lg">
    <div class="max-w-7xl auto px-4 sm:px-6 py-3 flex justify-center items-center">
      <Button
        variant="primary"
        text="Claim Your Salon's Website - $99"
        href="/pricing"
      />
    </div>
  </div>
</div>
INNEREOF

# 7. Update Pricing Page
cat << 'INNEREOF' > src/pages/pricing.astro
---
import Layout from '~/layouts/PageLayout.astro';
import HeroText from '~/components/widgets/HeroText.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import FAQs from '~/components/widgets/FAQs.astro';
import Features3 from '~/components/widgets/Features3.astro';
import { lifetimeDeal } from '~/data/pricingData';

const metadata = { title: 'Pricing | Address.Hair', description: 'One-time investment. Lifetime digital presence for your salon.' };
---
<Layout metadata={metadata}>
  <HeroText 
    tagline="Invest Once. Own It Forever."
    title="Stop Paying the 'SaaS Tax'." 
    subtitle="No monthly fees. No maintenance. One payment of $99 secures your vanity URL and automated boutique homepage forever."
  />
  <Pricing prices={[lifetimeDeal]} />
  <Features3
    title="Everything Included"
    columns={3}
    items={[
      { title: 'Vanity URL', description: 'address.hair/yoursalon', icon: 'tabler:link' },
      { title: 'Instagram Sync', description: 'Automated updates from your feed.', icon: 'tabler:brand-instagram' },
      { title: 'Boutique Design', description: 'Luxury layouts for salons.', icon: 'tabler:palette' },
      { title: 'Mobile First', description: 'Lightning fast on all devices.', icon: 'tabler:device-mobile' },
      { title: 'Booking Integration', description: 'Works with your existing tools.', icon: 'tabler:calendar' },
      { title: 'White-Glove Setup', description: 'We do the work for you.', icon: 'tabler:headset' },
    ]}
  />
</Layout>
INNEREOF

# 8. Update Contact Page
cat << 'INNEREOF' > src/pages/contact.astro
---
import Layout from '~/layouts/PageLayout.astro';
import HeroText from '~/components/widgets/HeroText.astro';
import GoogleContactForm from '~/components/widgets/GoogleContactForm.astro';

const metadata = {
  title: 'Contact | Address.Hair',
  description: 'Reach out for white-glove setup or support.',
};
---
<Layout metadata={metadata}>
  <HeroText 
    tagline="Support"
    title="We handle everything." 
    subtitle="Have questions about the Address.Hair Concept? Our team is ready to help you shine online."
  />
  <GoogleContactForm />
</Layout>
INNEREOF

# 9. Execution: Git Push
git add .
git commit -m "Fix: Corrected icon name and updated to Address.Hair Concept verbiage"
git push

echo "----------------------------------------------------"
echo "✅ Address.Hair CONCEPT DEPLOYED & PUSHED"
echo "✅ Icon Error Fixed (tabler:camera)"
echo "----------------------------------------------------"
