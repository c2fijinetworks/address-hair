#!/bin/bash

# 1. Update Navigation & Footer
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
  footNote: 'SalonWeb. © 2026 Address.Hair. All rights reserved.',
};
INNEREOF

# 2. Update Pricing Table (Fixing the .schedule.hair -> .address.hair preview)
sed -i 's/\.schedule\.hair/\.address\.hair/g' src/components/widgets/Pricing.astro

# 3. Update Pricing Data
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

# 4. Update Homepage (Expanded FAQs & Removed "Concept")
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
    tagline="Boutique Websites for Salons"
    title='<span class="text-accent dark:text-white">Your Salon Deserves a Digital Masterpiece.</span>'
    subtitle="We build and deploy elegant, high-converting websites that sync with your social media, so you can focus on making your clients look beautiful."
    actions={[{ variant: 'primary', text: 'Claim Your Salon\'s Website', href: '/pricing/' }, { text: 'Features', href: '#features' }]}
    image={{ src: '/images/hero-poster.webp', width: 1024, height: 576 }}
  />

  <Features
    id="features"
    title="Everything Your Salon Needs"
    subtitle="A Custom, high-end layout that mirrors the luxury and vibe of your physical salon space."
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
        <span class="text-accent dark:text-white">Instant Instagram Portfolio</span>
      </h3>
      <p>Your website shouldn't be a chore. We automatically sync your latest Instagram posts directly to your homepage so your site is always relevant.</p>
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
    title="Deep Dive: How Address.Hair Works"
    items={[
        { 
          title: 'What exactly is a Vanity URL vs. a Custom Domain?', 
          description: 'A Vanity URL is a professional, branded link like <strong>address.hair/yoursalon</strong>. It is included for free and is designed to replace generic, ugly links in your Instagram bio. However, if you want your own standalone domain (e.g., <strong>yoursalon.com</strong>), we offer full registration and technical setup for just $15/year. We handle the DNS, SSL certificates, and hosting so you don’t have to touch a single line of code.', 
          icon: 'tabler:link' 
        },
        { 
          title: 'Is it really "Same-Day" Setup?', 
          description: 'Yes. Unlike traditional agencies that take weeks, we operate as a boutique digital studio. If you submit your details by 2 PM, our team works in real-time to build your site, sync your social feeds, and deploy your URL before you close for the day. We value your time as much as you value your clients.', 
          icon: 'tabler:bolt' 
        },
        { 
          title: 'What is Address.Hair exactly?', 
          description: 'Address.Hair is a specialized web platform for hair professionals. We provide "Digital Addresses"—high-end, mobile-optimized homepages that act as the primary front door for your business. Instead of a complex, expensive website that sits stagnant, we provide a living page that pulls in your latest work from social media and directs clients straight to your booking button.', 
          icon: 'tabler:world' 
        },
        { 
          title: 'Do I need technical skills to keep it updated?', 
          description: 'None whatsoever. We built this for busy stylists. There is no dashboard to learn and no software to update. Your website stays fresh automatically by syncing with your Instagram. If you can take a photo of a client, you can maintain your Address.Hair website.', 
          icon: 'tabler:tool' 
        },
    ]}
  />
</Layout>
INNEREOF

# 5. Update About Page
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

# 6. Update Logo Text
# Assuming SITE.name in config.yaml should be updated, but for hardcoded logo:
sed -i 's/Schedule\.Hair/Address\.Hair/g' src/components/Logo.astro

# 7. Update Announcement Bar
cat << 'INNEREOF' > src/components/widgets/Announcement.astro
<div class="dark text-sm bg-black hidden md:flex items-center justify-center overflow-hidden px-3 py-2 relative text-ellipsis whitespace-nowrap">
  <div class="flex items-center gap-2">
    <span>✨ </span><span class="text-white font-medium">Claim your professional <strong>address.hair/yoursalon</strong> vanity URL today.</span>
  </div>
  <div class="absolute right-4 top-0 h-full flex items-center"><span class="text-white font-medium">Same-day setup. Just $99</span></div>
</div>
INNEREOF

# 8. Execution: Git Push
git add .
git commit -m "Refactor: Final Address.Hair branding, expanded deep FAQs, removed Concept wording"
git push

echo "----------------------------------------------------"
echo "✅ Address.Hair BRANDING DEPLOYED & PUSHED"
echo "✅ Pricing Preview Fixed (.address.hair)"
echo "✅ FAQ Section Expanded"
echo "✅ Site Name Fixed (Address.Hair)"
echo "----------------------------------------------------"
