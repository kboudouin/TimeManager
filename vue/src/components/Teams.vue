<template>
  <div>
    <h1>TEAM</h1>
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>

    <div class="carousel rounded-box">
  <div class="carousel-item">
    <img src="https://www.nasdaq.com/sites/acquia.prod/files/image/29525db076bcc42505a356e55dbe94f38b28530b_getty-stock-market-data.jpg?247513527" alt="Burger" />
  </div> 
  <div class="carousel-item">
    <img src="/images/stock/photo-1565098772267-60af42b81ef2.jpg" alt="Burger" />
  </div> 
  <div class="carousel-item">
    <img src="/images/stock/photo-1572635148818-ef6fd45eb394.jpg" alt="Burger" />
  </div> 
  <div class="carousel-item">
    <img src="/images/stock/photo-1494253109108-2e30c049369b.jpg" alt="Burger" />
  </div> 
  <div class="carousel-item">
    <img src="/images/stock/photo-1550258987-190a2d41a8ba.jpg" alt="Burger" />
  </div> 
  <div class="carousel-item">
    <img src="/images/stock/photo-1559181567-c3190ca9959b.jpg" alt="Burger" />
  </div> 
  <div class="carousel-item">
    <img src="/images/stock/photo-1601004890684-d8cbf643f5f2.jpg" alt="Burger" />
  </div>
</div>


  </div>
</template>

<script>


export default {
  components: {
 
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

</style>
