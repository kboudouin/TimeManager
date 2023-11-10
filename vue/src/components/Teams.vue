<template>
  <div>
    <h1>TEAM</h1>
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>

    <div class="carousel rounded-box">
  <div class="carousel-item">
    <div class="flex flex-col w-full lg:flex-row">
  <div class="grid flex-grow h-32 card bg-base-300 rounded-box place-items-center">content</div> 
  <div class="divider lg:divider-horizontal">OR</div> 
  <div class="grid flex-grow h-32 card bg-base-300 rounded-box place-items-center">content</div>
</div>

  </div> 
  <div class="carousel-item">
    <img src="https://etudestech.com/wp-content/uploads/2022/12/entreprise-informatique-scaled.jpeg" alt="Burger" />
    <div class="bg-white p-4 rounded">
              <p>Your content here</p>
            </div>
  </div> 
  <div class="carousel-item">
    <img src="https://etudestech.com/wp-content/uploads/2022/12/entreprise-informatique-scaled.jpeg" alt="Burger" />
    <div class="bg-white p-4 rounded">
              <p>Your content here</p>
            </div>
  </div> 
  <div class="carousel-item">
    <img src="https://etudestech.com/wp-content/uploads/2022/12/entreprise-informatique-scaled.jpeg" alt="Burger" />
    <div class="bg-white p-4 rounded">
              <p>Your content here</p>
            </div>
  </div> 
  <div class="carousel-item">
    <img src="https://etudestech.com/wp-content/uploads/2022/12/entreprise-informatique-scaled.jpeg" alt="Burger" />
    <div class="bg-white p-4 rounded">
              <p>Your content here</p>
            </div>
  </div> 
  <div class="carousel-item">
    <img src="https://etudestech.com/wp-content/uploads/2022/12/entreprise-informatique-scaled.jpeg" alt="Burger" />
    <div class="bg-white p-4 rounded">
              <p>Your content here</p>
            </div>
  </div> 
  <div class="carousel-item">
    <img src="https://etudestech.com/wp-content/uploads/2022/12/entreprise-informatique-scaled.jpeg" alt="Burger" />
    <div class="bg-white p-4 rounded">
              <p>Your content here</p>
            </div>
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
