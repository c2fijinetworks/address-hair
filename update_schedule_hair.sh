#!/bin/bash

# 1. Update Navigation
cat << 'INNER' > src/navigation.ts
import { getPermalink } from './utils/permalinks';

export const headerData = {
  links: [
    { text: 'Features', href: getPermalink('/#features') },
    { text: 'How It Works', href: getPermalink('/#howitworks') },
    { text: 'The Story', href: getPermalink('/about') },
    { text: 'Grab Your Vanity URL', href: getPermalink('/pricing') },
  ],
  actions: [
    { text: 'Get Lifetime Access - $99', variant: 'primary', href: '/pricing' }
  ],
};

export const footerData = {
  links: [
    {
      title: 'Schedule.Hair',
      links: [
        { text: "Claim Your Vanity URL – $99", href: getPermalink('/pricing') },
        { text: 'Why We Support Stylists', href: getPermalink('/about') },
        { text: 'Support', href: getPermalink('/contact') },
      ],
    },
  ],
  secondaryLinks: [
    { text: 'Terms', href: getPermalink('/terms') },
    { text: 'Privacy', href: getPermalink('/privacy') },
  ],
  socialLinks: [],
  footNote: \`
    <div class="inline-flex items-center justify-center flex-wrap">
      <img class='w-5 h-5 mr-2 rounded-sm align-middle' src='/images/footer-icon.webp' alt='Schedule Hair' loading='lazy'>
      <span class="align-middle">✂️ Fill your chairs. | © \${new Date().getFullYear()} <a class="text-blue-600 underline dark:text-muted" href="#">Schedule.Hair</a></span>
    </div>
  \`,
};
INNER

# 2. Update Pricing Data
cat << 'INNER' > src/data/pricingData.ts
export const lifetimeDeal = {
  title: 'Lifetime Booking Plan',
  subtitle: 'Ditch the monthly subscription fees.',
  price: 99,
  period: 'One-time payment',
  items: [
    { description: 'Custom Vanity URL (yoursalon.schedule.hair)' },
    { description: 'Premium Salon Branding Setup' },
    { description: 'Real-time Calendar Availability' },
    { description: 'Mobile-First Booking Interface' },
    { description: 'Social Media & Google Integration' },
    { description: 'Unlimited Appointments & Services' },
    { description: 'Lifetime Updates & Premium Hosting' },
  ],
  callToAction: {
    target: '_blank' as const,
    text: 'Claim My Vanity URL Now',
    href: '#',
    variant: 'success',
  },
};
INNER

# 3. Update Homepage
cat << 'INNER' > src/pages/index.astro
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
  title: 'Schedule.Hair | Premium Vanity Booking URLs for Stylists',
  description: 'Replace clunky booking links with a beautiful, branded scheduling page on your own professional domain. One-time fee, lifetime access.',
  ignoreTitleTemplate: true,
};
---

<Layout metadata={metadata}>
  <Fragment slot="header">
    <Header {...headerData} isSticky />
  </Fragment>
  
  <Hero2
    tagline="Boutique Web Development for Salons"
    title='<span class="text-accent dark:text-white">Fill Your Chairs with a Pro Booking Link.</span>'
    subtitle="We replace clunky generic links with a beautiful scheduling page on your own professional vanity URL (yoursalon.schedule.hair). Same-day setup, premium hosting included."
    actions={[
      { variant: 'primary', text: 'Get Your Booking Link Today', href: '/pricing/' },
      { text: 'See How It Works', href: '#howitworks' },
    ]}
    video="/images/hero-animation.mp4" 
    poster="/images/hero-poster.webp" 
    image={{ width: 1024, height: 576 }}
    testimonial={{
        quote: "Generic links felt cheap. Switching to my custom schedule.hair page made my brand look high-end instantly. My clients love the new flow!",
        name: "Sarah L., Salon Owner"
    }}
  />
  
  <Features
    class="-mt-16"
    id="features"
    title="Luxury Booking, Simplified"
    subtitle="We handle the tech. You focus on the hair. Here is how we upgrade your business:"
    columns={2}
    items={[
        { title: 'Custom Salon Branding', description: 'Your booking page perfectly matches your logo, colors, and unique salon vibe. No more generic templates.', icon: 'tabler:palette' },
        { title: 'Frictionless Scheduling', description: 'An easy-to-use calendar designed for high conversion. Clients book in seconds without annoying login requirements.', icon: 'tabler:calendar-check' },
        { title: 'Social Integration', description: 'Optimized for your Google Business Profile, Instagram bio, and TikTok. Turn followers into appointments automatically.', icon: 'tabler:share' },
        { title: 'No Monthly "SaaS Tax"', description: 'Stop paying $50-$150 every month. One payment of $99 secures your branded booking engine for life.', icon: 'tabler:pig-money' },
    ]}
  />

<Content
    class="-mt-16"
    items={[
        { title: 'Mobile-First Design', description: '90% of your clients book on their phones. Our apps are lightning-fast and intuitive on every device.', icon: 'tabler:device-mobile' },
        { title: 'Service-Based Pricing', description: 'Clearly display Balayage, Cuts, and Colors with tiered pricing and custom durations.', icon: 'tabler:scissors' },
        { title: 'Real-Time Sync', description: 'Your availability is always up to date. Eliminate double bookings and awkward scheduling conflicts.', icon: 'tabler:refresh' },
        { title: 'Vanity URL for Life', description: 'Own a professional address like velvet.schedule.hair that clients will actually remember.', icon: 'tabler:link' },
    ]}
    image={{ src: '/images/testimonial-2.webp', alt: 'Stylist managing appointments' }}
  >
    <Fragment slot="content">
      <h3 class="text-2xl font-bold tracking-tight dark:text-white sm:text-3xl mb-2">
        <span class="text-accent dark:text-white">The booking experience your clients deserve.</span>
      </h3>
    </Fragment>
    <Fragment slot="bg"><div class="absolute inset-0 bg-blue-50 dark:bg-transparent"></div></Fragment>
  </Content>

  <div id="howitworks" class="scroll-mt-20">
    <Steps2
      title="Three Steps to a Full Calendar"
      subtitle="We handle the technical heavy lifting so you can focus on your craft."
      items={[
        {
          title: 'Step 1: Send Your Availability',
          description: 'Tell us your services and schedule. We tailor the engine to fit your specific workflow.',
          icon: 'tabler:number-1',
        },
        {
          title: 'Step 2: We Build & Host',
          description: 'Our studio builds your custom booking app and hosts it on your professional schedule.hair domain.',
          icon: 'tabler:number-2',
        },
        {
          title: 'Step 3: Start Getting Booked',
          description: 'Add your new link to Instagram and Google. Watch your chair fill up on autopilot.',
          icon: 'tabler:number-3',
        },
      ]}
      image={{ 
        src: '/images/testimonial-6.webp', 
        alt: 'Schedule Hair system in action',
        width: 1024,
        height: 1024 
      }}
    />
  </div>

  <Pricing
    title='<span class="text-accent dark:text-white">One-Time Investment. Ready in 24 Hours.</span>'
    prices={[lifetimeDeal]}
  />

  <FAQs
    class="-mt-16 px-6"
    title="Frequently Asked Questions"
    items={[
        { title: 'Do I have to pay monthly?', description: 'No. We believe in ownership. You pay once for the setup and professional hosting, and you own your booking link for life.', icon: 'tabler:help' },
        { title: 'Can I change my services later?', description: 'Absolutely. Your system is flexible. You can update pricing, hours, and services whenever your business evolves.', icon: 'tabler:settings' },
        { title: 'What is a Vanity URL?', description: 'Instead of a messy link like "booking-app.com/u/12345?salon=true", you get a clean, branded link like "yoursalon.schedule.hair".', icon: 'tabler:link' },
        { title: 'Is my data secure?', description: 'Yes. We use industry-standard encryption and premium hosting to ensure your clients data and your calendar are always protected.', icon: 'tabler:lock' },
    ]}
  >
    <Fragment slot="bg"><div class="absolute inset-0 bg-blue-50 dark:bg-transparent"></div></Fragment>
  </FAQs>

<Steps2
    class="-mt-16"
    title="Ready to upgrade your client experience?"
    subtitle="Join the elite salons ditching generic links for custom-branded booking apps."
    items={[
      {
        title: 'Same-Day Delivery',
        description: 'Get your custom vanity URL live in less than 24 hours.',
        icon: 'tabler:bolt',
      },
      {
        title: 'White-Glove Setup',
        description: 'We do all the tech work. You just provide the salon details.',
        icon: 'tabler:check',
      },
      {
        title: 'Save $600+ Per Year',
        description: 'Stop the subscription drain. Pay once and keep your profits.',
        icon: 'tabler:coin',
      },
    ]}
    callToAction={{ text: 'Get Your Booking Link Today', href: '/pricing/' }}
    image={{ src: '/images/testimonial-3.webp', alt: 'Schedule Hair Booking', width: 600, height: 600 }}
  />
</Layout>
INNER

# 4. Update Announcement Bar
cat << 'INNER' > src/components/widgets/Announcement.astro
<div
  class="dark text-sm bg-black hidden md:flex items-center justify-center overflow-hidden px-3 py-2 relative text-ellipsis whitespace-nowrap"
>
  <div class="flex items-center gap-2">
    <span>✨ </span>
    <span class="text-white font-medium">
      Ditch generic links. Get your branded <strong>yoursalon.schedule.hair</strong> booking page today.
    </span>
  </div>
  <div class="absolute right-4 top-0 h-full flex items-center">
    <span class="text-white font-medium">Limited Lifetime Deal: $99</span>
  </div>
</div>
INNER

# 5. Update About Page
cat << 'INNER' > src/pages/about.astro
---
import Hero2 from '~/components/widgets/Hero2.astro';
import Content from '~/components/widgets/Content.astro';
import Layout from '~/layouts/PageLayout.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import { lifetimeDeal } from '~/data/pricingData';

const metadata = {
  title: 'Our Mission - Schedule.Hair | Built for Stylists',
  description: 'We built Schedule.Hair because hair is art, and your booking experience should reflect that.',
  ignoreTitleTemplate: true,
};
---

<Layout metadata={metadata}>
<Hero2
    tagline="You Create the Art."
    title='<span class="text-accent dark:text-white">We Fill the Chairs.</span>'
    subtitle="Schedule.Hair was born from a simple observation: Most booking software looks like a spreadsheet from 1995. We build modern, luxury booking engines for the elite hair professional."
    video="/images/hero-animation.mp4" 
    poster="/images/hero-poster.webp"
    actions={[
      { variant: 'primary', text: 'Secure Your Vanity URL - $99', href: '/pricing/' },
    ]}
  />
  <Content
    isReversed
    items={[
        { title: 'The Professional Edge', description: 'Generic links feel temporary. A custom schedule.hair domain tells your clients that you are a serious, established professional.', icon: 'tabler:certificate' },
        { title: 'Time is Money', description: 'Every minute you spend texting back and forth about availability is a minute you aren’t behind the chair. We automate the admin.', icon: 'tabler:clock' },
        { title: 'Luxury Experience', description: 'From the first click to the final confirmation, we ensure your client’s journey is as polished as the hair you style.', icon: 'tabler:sparkles' },
    ]}
  >
    <Fragment slot="content">
      <h3 class="text-2xl font-bold tracking-tight dark:text-white sm:text-3xl mb-2">
        Why we focus on <span class="text-accent">Salon Professionals</span>
      </h3>
      <p>In a world of generic apps, your brand needs to stand out. Your booking link is often the first interaction a new client has with your business—make it count.</p>
    </Fragment>
    <Fragment slot="image">
       <img src="/images/testimonial-4.webp" alt="Professional salon environment" class="rounded-lg shadow-xl w-full" />
    </Fragment>
  </Content>

  <Pricing
    class="pb-0"
    title='<span class="text-accent dark:text-white">Invest in Your Salon’s Brand.</span>'
    prices={[lifetimeDeal]}
  />
</Layout>
INNER

# 6. Update Pricing Page Logic
# Note: Update item_name in the pricing widget to match the new concept
sed -i 's/HairTestimonial QR Review Engine/Schedule.Hair Professional Booking Engine/g' src/components/widgets/Pricing.astro
sed -i 's/HTFP99/SHLTD99/g' src/components/widgets/Pricing.astro

chmod +x update_schedule_hair.sh
./update_schedule_hair.sh
rm update_schedule_hair.sh

echo "Schedule.Hair Refactor Complete! Please push to Github."
