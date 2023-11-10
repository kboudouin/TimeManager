<template>
  <div>
    <h1>TEAM</h1>
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>

    <!-- Use the carousel component -->
    <Carousel :autoplay="true" :autoplaySpeed="3000">
      <div v-for="(item, index) in items" :key="index" class="carousel-item">
        <p>{{ item.text }}</p>
      </div>
    </Carousel>
  </div>
</template>

<script>
import Carousel from 'vue-slick-carousel';
import 'vue-slick-carousel/dist/vue-slick-carousel.css';

export default {
  components: {
    Carousel,
  },
  data() {
    return {
      userUsername: null,
      id: null,
      EMAIL: null,
      selectedMembers: [],
      LIST: [],
      items: [
        { text: 'test testte 1' },
        { text: 'test testte 2' },
        { text: 'test testte 3' },
        { text: 'test testte 4' },
        { text: 'test testte 5' },
        { text: 'test testte 6' },
        { text: 'test testte 7' },
      ],
    };
  },
  created() {
    // Récupérez la valeur depuis le localStorage
    this.userUsername = localStorage.getItem('userUsername');
    this.id = localStorage.getItem('userId');
    this.EMAIL = localStorage.getItem('userEmail');
  },
};
</script>

<style>
/* Add any custom styles for your carousel here */
</style>
