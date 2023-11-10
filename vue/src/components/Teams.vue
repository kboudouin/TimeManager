<template>
  <h1> TEAM</h1>
  <div class="container mx-auto py-4">
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>

      <div class="carousel carousel-end rounded-box">
  <div class="carousel-item">
    <p> test testte </p>
    <img src="/images/stock/photo-1559703248-dcaaec9fab78.jpg" alt="Drink" />
  </div> 
  <div class="carousel-item">
    <p> test testte </p>
    <img src="/images/stock/photo-1565098772267-60af42b81ef2.jpg" alt="Drink" />
  </div> 
  <div class="carousel-item">
    <p> test testte </p>
    <img src="/images/stock/photo-1572635148818-ef6fd45eb394.jpg" alt="Drink" />
  </div> 
  <div class="carousel-item">
    <p> test testte </p>
    <img src="/images/stock/photo-1494253109108-2e30c049369b.jpg" alt="Drink" />
  </div> 
  <div class="carousel-item">
    <p> test testte </p>
    <img src="/images/stock/photo-1550258987-190a2d41a8ba.jpg" alt="Drink" />
  </div> 
  <div class="carousel-item">
    <p> test testte </p>
    <img src="/images/stock/photo-1559181567-c3190ca9959b.jpg" alt="Drink" />
  </div> 
  <div class="carousel-item">
    <p> test testte </p>
    <img src="/images/stock/photo-1601004890684-d8cbf643f5f2.jpg" alt="Drink" />
  </div>
</div>
    
  
</section>
    
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";
import VueCookies from "vue-cookies";
import { useToast } from "vue-toast-notification";

export default {
  data() {
    return {
      userUsername: null,
      id: null,
      EMAIL: null,
      selectedMembers: [],
      LIST: [],
    };
  },
  created() {
    // Récupérez la valeur depuis le localStorage
    this.userUsername = localStorage.getItem("userUsername");
    this.id = localStorage.getItem("userId");
    this.EMAIL = localStorage.getItem("userEmail");
  },
  methods: {
  
  },

  setup() {
    const teams = [
    {
      leader: "John Doe",
      description: "Team A - Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      members: [
        { name: "Alice", surname: "Doe", description: "Lorem ipsum dolor sit amet." },
        { name: "Bob", surname: "Doe", description: "Consectetur adipiscing elit." },
        // Add more members as needed
      ],
    },
    {
      leader: "Jane Smith",
      description: "Team B - Ut enim ad minim veniam, quis nostrud exercitation ullamco.",
      members: [
        { name: "Charlie", surname: "Smith", description: "Duis aute irure dolor in reprehenderit." },
        { name: "David", surname: "Smith", description: "Excepteur sint occaecat cupidatat non proident." },

      ],
    },
//team
  ];


  return {
    teams,
  };
},
};
</script>
