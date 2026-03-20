#!/bin/bash

# 1. Update Navigation
cat << 'INNEREOF' > src/navigation.ts
import { getPermalink } from './utils/permalinks';

export const headerData = {
  links: [
    { text: 'Features', href: getPermalink('/#features') },
    { text: 'Process', href: getPermalink('/#process') },
    { text: 'The Story', href: getPermalink('/about') },
    { text: 'Claim Your URL', href: getPermalink('/pricing') },
  ],
  actions: [
    { text: 'Get Started - $99', variant: 'primary', href: '/pricing' }
  ],
};

export const footerData = {
  links: [
    {
      title: 'SalonWeb',
      links: [
        { text: "Claim Your Site – $99", href: getPermalink('/pricing') },
        { text: 'Why We Love Salons', href: getPermalink('/about') },
        { text: 'Support', href: getPermalink('/contact') },
      ],
    },
  ],
  secondaryLinks: [
    { text: 'Terms of Service', href: getPermalink('/terms') },
    { text: 'Privacy Policy', href: getPermalink('/privacy') },
  ],
  socialLinks: [],
  footNote: '✂️ Your digital home. | © ' + new Date().getFullYear() + ' Address.Hair. All rights reserved.',
};
INNEREOF

# 2. Update Pricing Data
cat << 'INNEREOF' > src/data/pricingData.ts
export const lifetimeDeal = {
  title: 'Salon Homepage Plan (Lifetime)',
  subtitle: 'One-time payment for a professional digital address.',
  price: 99,
  period: 'One-time payment',
  items: [
    { description: 'Premium Vanity URL (address.hair/yoursalon)' },
    { description: 'Real-time Instagram Content Sync' },
    { description: 'Boutique Aesthetic Design' },
    { description: 'Mobile-First User Experience' },
    { description: 'Integrated Booking Link Support' },
    { description: 'Zero Maintenance / No Monthly Fees' },
    { description: 'White-Glove Tech Support Included' },
  ],
  callToAction: { target: '_blank' as const, text: 'Claim My Salon URL Now', href: '#', variant: 'success' },
};
INNEREOF

# 3. Update Homepage (index.astro)
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
    tagline="Boutique Web Development for Salons"
    title='<span class="text-accent dark:text-white">Your Salon Deserves a Digital Masterpiece.</span>'
    subtitle="We build and deploy elegant, high-converting websites that sync with your social media, so you can focus on making your clients look beautiful."
    actions={[{ variant: 'primary', text: 'Claim Your Salon\'s Website', href: '/pricing/' }, { text: 'See How It Works', href: '#features' }]}
    image={{ src: '/images/hero-poster.webp', width: 1024, height: 576 }}
  />

  <Features
    id="features"
    title="Everything Your Salon Needs"
    subtitle="The ultimate digital presence, designed specifically for luxury hair professionals."
    items={[
        { title: 'Aesthetic Design', description: 'A custom, high-end layout that mirrors the luxury and vibe of your physical salon space.', icon: 'tabler:palette' },
        { title: 'Automated Social Feeds', description: 'We sync your Instagram directly to your site. Fresh content, zero effort.', icon: 'tabler:brand-instagram' },
        { title: 'Essential Business Info', description: 'Integrated booking links, clear location maps, and up-to-date hours for your clients.', icon: 'tabler:info-circle' },
        { title: 'Professional Hosting', description: 'We handle the tech. Custom Vanity domains and lightning-fast hosting included.', icon: 'tabler:cloud-computing' },
    ]}
  />

  <Content
    isReversed
    tagline="Always Fresh. Zero Maintenance."
    title="Your site stays as fresh as your latest client's blowout."
    items={[
        { title: 'Real-time Instagram Sync', description: 'Your portfolio updates automatically every time you post a new transformation.', icon: 'tabler:refresh' },
        { title: 'Automatic Content Refresh', description: 'No more outdated websites. Your latest work is always front and center.', icon: 'tabler:device-camera' },
    ]}
    image={{ src: '/images/testimonial-2.webp', alt: 'Stylist working on a client' }}
  >
    <Fragment slot="content">
      <h3 class="text-2xl font-bold tracking-tight dark:text-white sm:text-3xl mb-2">
        <span class="text-accent dark:text-white">Website Maintenance is a Thing of the Past</span>
      </h3>
      <p>We automatically sync your latest Instagram posts directly to your homepage.</p>
    </Fragment>
  </Content>

  <div id="process" class="scroll-mt-20">
    <Steps2
      title="The Path to a Better Presence"
      subtitle="Three simple steps to your new digital home."
      items={[
        { title: '01. Sign up', description: 'Secure your brand with your salon’s name and vanity URL.', icon: 'tabler:number-1' },
        { title: '02. We Build & Sync', description: 'Our studio crafts your site and connects your social feeds for auto-updates.', icon: 'tabler:number-2' },
        { title: '03. Launch & Shine', description: 'Go live on address.hair/yoursalon and start attracting high-value clients.', icon: 'tabler:number-3' },
      ]}
      image={{ src: '/images/testimonial-6.webp', alt: 'Address Hair process' }}
    />
  </div>

  <Pricing title='Ready to elevate your salon’s brand?' prices={[lifetimeDeal]} />

  <FAQs
    title="Frequently Asked Questions"
    items={[
        { title: 'What exactly is a Vanity URL?', description: 'It is a clean, professional link like <strong>address.hair/velvet-studio</strong>. It replaces messy links and makes your salon look like an established, elite brand.', icon: 'tabler:link' },
        { title: 'Do I need technical skills?', description: 'None. We handle the design, hosting, and social media integration. If you can post to Instagram, you can maintain this website.', icon: 'tabler:tool' },
        { title: 'How does the Instagram sync work?', description: 'We connect to your public business profile and automatically display your latest posts as a live gallery on your site. Fresh content, zero effort.', icon: 'tabler:brand-instagram' },
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
  title: 'The Mission | Address.Hair', 
  description: 'Why we build digital masterpieces for the world’s best stylists.' 
};
---
<Layout metadata={metadata}>
  <Hero2
    tagline="Our Studio"
    title='We Believe Your Salon Deserves an <span class="text-accent">Address</span>'
    subtitle="In a world of generic social media profiles, a custom homepage on Address.Hair signals that you are an established, elite professional. We bridge the gap between your artistry and your online presence."
    actions={[{ variant: 'primary', text: 'Secure My Address', href: '/pricing/' }]}
    image={{ src: '/images/hero-poster.webp', alt: 'Address.Hair Professional Branding' }}
  />
  
  <Content
    items={[
        { title: 'A Digital Handshake', description: 'Your website is often the first luxury experience a client has with your brand. We make sure it is a five-star experience.', icon: 'tabler:award' },
        { title: 'Built for Beauty', description: 'Our layouts are optimized to showcase high-resolution artistry, color work, and the vibe of your space.', icon: 'tabler:brush' },
    ]}
  >
    <Fragment slot="content">
      <h3 class="text-3xl font-bold mb-4">Professionalism: Beyond the Bio Link</h3>
      <p class="text-lg text-muted">Address.Hair was created to give stylists a high-end "front door" that is always updated and never requires technical maintenance.</p>
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
    <span>✨ </span><span class="text-white font-medium">Claim your professional <strong>address.hair/yoursalon</strong> vanity URL today.</span>
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
    <div class="max-w-7xl mx-auto px-4 sm:px-6 py-3 flex justify-center items-center">
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
    subtitle="Most website builders charge $30–$60 every single month. At Address.Hair, you pay a flat $99 one-time fee for your vanity URL and boutique salon homepage. No monthly fees, ever."
  />
  <Pricing prices={[lifetimeDeal]} />
  <Features3
    title="Everything Included in Your License"
    columns={3}
    items={[
      { title: 'Vanity URL Setup', description: 'Your own branded address (address.hair/yoursalon) for life.', icon: 'tabler:link' },
      { title: 'Instagram Sync', description: 'Automated content updates every time you post a new look.', icon: 'tabler:brand-instagram' },
      { title: 'Boutique Design', description: 'Custom brand colors and logo integration for a luxury feel.', icon: 'tabler:palette' },
      { title: 'Mobile Optimization', description: 'Ultra-fast loading for clients booking on mobile.', icon: 'tabler:device-mobile' },
      { title: 'Booking Integration', description: 'Link directly to your existing booking software.', icon: 'tabler:calendar' },
      { title: 'Lifetime Updates', description: 'All future software improvements included at no extra cost.', icon: 'tabler:refresh' },
    ]}
  />
</Layout>
INNEREOF

# 8. Execution: Commit and Push
git add .
git commit -m "Refactor: Convert to Address.Hair Concept - Salon Homepages with Instagram Sync"
git push

echo "----------------------------------------------------"
echo "✅ Address.Hair CONCEPT DEPLOYED SUCCESSFULLY"
echo "✅ Git Commit & Push Completed"
echo "✅ Cloudflare Pages should begin building shortly"
echo "----------------------------------------------------"
