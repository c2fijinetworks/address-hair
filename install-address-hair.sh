#!/bin/bash

# 1. Update Navigation & Logo text (Footer/Header/Logo)
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

# Ensure Logo component uses the correct text
sed -i 's/SITE?.name/ "Address.Hair" /g' src/components/Logo.astro
sed -i 's/Schedule\.Hair/Address\.Hair/g' src/components/Logo.astro

# 2. Update Homepage with Deep Content and Alternating Layouts
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
  description: 'Your Salon Deserves a Digital Masterpiece. High-end websites with automated Instagram sync and vanity URLs for elite professionals.' 
};
---
<Layout metadata={metadata}>
  <Fragment slot="header"><Header {...headerData} isSticky /></Fragment>
  
  <Hero2
    tagline="Boutique Web Development for Salons"
    title='<span class="text-accent dark:text-white">Your Salon Deserves a Digital Masterpiece.</span>'
    subtitle="We build and deploy elegant, high-converting websites that sync with your social media portfolio in real-time. Stand out with a professional address while you focus on the chair."
    actions={[{ variant: 'primary', text: 'Claim Your Salon\'s Website', href: '/pricing/' }, { text: 'Features', href: '#features' }]}
    image={{ src: '/images/hero-poster.webp', width: 1024, height: 576 }}
  />

  <Features
    id="features"
    title="Everything Your Salon Needs"
    subtitle="We have distilled the essential elements of a high-performance salon website into a single, beautiful package."
    items={[
        { 
          title: 'Aesthetic Boutique Design', 
          description: 'This is not a generic template. Our layouts are custom-crafted to mirror the luxury, lighting, and unique vibe of your physical salon space. We prioritize high-resolution imagery and elegant typography that tells your brand story before the client even walks through the door. Every pixel is designed to build trust and signal elite-level service.', 
          icon: 'tabler:palette' 
        },
        { 
          title: 'Automated Social Feeds', 
          description: 'Your website should never be out of date. We sync your Instagram directly to your homepage gallery, creating a living, breathing portfolio. Every time you post a fresh transformation or a new style, your website updates automatically. This ensures your site stays as fresh as your latest client blow-out with absolutely zero manual effort on your part.', 
          icon: 'tabler:brand-instagram' 
        },
        { 
          title: 'Essential Business Strategy', 
          description: 'We integrate your primary booking engine directly into a clear, high-conversion layout. Beyond just a link, we include interactive location maps and up-to-date hours designed specifically for mobile users. We optimize the path from search to scheduled appointment, ensuring that local clients can find you and book you with a single tap.', 
          icon: 'tabler:info-circle' 
        },
        { 
          title: 'Professional Technical Suite', 
          description: 'Stop worrying about servers or security. We handle the enterprise-grade tech behind your professional address. Our websites are hosted on lightning-fast global networks, ensuring your high-res portfolio loads instantly on any device. We provide SSL security and custom domain routing so your digital home is as stable and professional as your salon business.', 
          icon: 'tabler:cloud-computing' 
        },
    ]}
  />

  <Content
    isReversed={false}
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
      <p>Your website shouldn't be a chore. We automatically sync your latest Instagram posts directly to your homepage so your site is always relevant and reflects your current skill level.</p>
    </Fragment>
  </Content>

  <div id="process" class="scroll-mt-20">
    <Steps2
      isReversed={true}
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
          description: 'Address.Hair is the definitive digital presence for elite stylists. Beyond being a beautiful homepage, it serves as a powerful SEO asset. By adding your Address.Hair link as the official "Website" on your Google Business Profile, you create a massive authority signal. Google prioritizes professional, dedicated URLs over generic social links or messy booking IDs. This makes your salon stand out in local search and helps you outrank the competition.', 
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

# 3. Update About Page with High Depth
cat << 'INNEREOF' > src/pages/about.astro
---
import Hero2 from '~/components/widgets/Hero2.astro';
import Content from '~/components/widgets/Content.astro';
import Layout from '~/layouts/PageLayout.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import { lifetimeDeal } from '~/data/pricingData';

const metadata = { 
  title: 'The Story | Address.Hair', 
  description: 'Why we build boutique websites for the world’s best hair stylists.' 
};
---
<Layout metadata={metadata}>
  <Hero2
    tagline="The Story"
    title='Elite Websites for <span class="text-accent">Elite Stylists</span>'
    subtitle="We believe your digital address should be as beautiful as the transformations you create at the chair. Your website is your digital handshake, and it should reflect the luxury your brand represents."
    actions={[{ variant: 'primary', text: 'Secure My Address', href: '/pricing/' }]}
    image={{ src: '/images/hero-poster.webp', alt: 'Address.Hair Professional Branding' }}
  />
  
  <Content
    isReversed={false}
    items={[
        { 
          title: 'Mirror Your Luxury', 
          description: 'You’ve spent years perfecting your craft and thousands of dollars designing your salon space. Why settle for a generic booking link? We believe your digital home should mirror the luxury and vibe of your physical shop. We focus on the aesthetic details that signal to a client that they are in expert hands before they even book.', 
          icon: 'tabler:award' 
        },
        { 
          title: 'Focus on Artistry, Not Tech', 
          description: 'Stylists are artists, not web developers. Our mission is to bridge the gap between your creativity and the technical world. We handle the servers, the code, and the social media integrations so that your online presence stays perfect while you focus on making your clients look and feel beautiful. We are your backend tech team.', 
          icon: 'tabler:brush' 
        },
    ]}
  >
    <Fragment slot="content">
      <h3 class="text-3xl font-bold mb-4">Our Technical Philosophy</h3>
      <p class="text-lg text-muted">In the modern beauty industry, "Generic" is the enemy of "Luxury." We move beyond the cluttered links and messy apps to provide a clean, dedicated digital address that establishes you as a local authority. Address.Hair is built on the belief that a website shouldn't be a chore—it should be a salesperson that never sleeps.</p>
    </Fragment>
    <Fragment slot="image">
       <img src="/images/testimonial-4.webp" alt="Elite salon styling" class="rounded-lg shadow-xl w-full" />
    </Fragment>
  </Content>

  <Content
    isReversed={true}
    items={[
        { 
          title: 'A New Standard for Salons', 
          description: 'The Address.Hair system was designed by a team that understands the salon industry. We know that content is king, but time is scarce. That is why our Instagram Sync is the core of our engine. Your best work is already on social media; we simply give it the high-end gallery it deserves on a professional domain.', 
          icon: 'tabler:rocket' 
        },
        { 
          title: 'White-Glove Support', 
          description: 'When you join Address.Hair, you aren\'t just buying a software license. You are getting a white-glove setup service. We configure your vanity URL, link your social accounts, and ensure your site is perfectly indexed by Google. We handle the heavy lifting so you can stay behind the chair where you belong.', 
          icon: 'tabler:headset' 
        },
    ]}
  >
    <Fragment slot="content">
      <h3 class="text-3xl font-bold mb-4">The Digital Address Difference</h3>
      <p class="text-lg text-muted">Whether you are a solo booth renter or a high-end salon owner, your digital address is your most valuable asset. It is where your reputation lives online. We take that responsibility seriously, ensuring your site is fast, secure, and stunningly beautiful.</p>
    </Fragment>
    <Fragment slot="image">
       <img src="/images/testimonial-3.webp" alt="Stylist working" class="rounded-lg shadow-xl w-full" />
    </Fragment>
  </Content>

  <Pricing title="Ready to Own Your Professional Identity?" prices={[lifetimeDeal]} />
</Layout>
INNEREOF

# 4. Final Branding Push
git add .
git commit -m "Final Polish: Deep content volume, Logo Branding fixed, Alternating layouts"
git push

echo "----------------------------------------------------"
echo "✅ Address.Hair FINAL BRANDING DEPLOYED"
echo "✅ Sitename and Logo Fixed"
echo "✅ Expanded Content Depth in Features/About"
echo "✅ Alternating Layouts for Visual Flow"
echo "----------------------------------------------------"
