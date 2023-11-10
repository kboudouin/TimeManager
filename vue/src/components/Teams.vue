<template>
  <h1> TEAM</h1>
  <div class="container mx-auto py-4">
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>
    
      <!--Carousel controls - prev item-->
<button
  class="absolute bottom-0 left-0 top-0 z-[1] flex w-[15%] items-center justify-center border-0 bg-none p-0 text-center text-white opacity-50 transition-opacity duration-150 ease-[cubic-bezier(0.25,0.1,0.25,1.0)] hover:text-white hover:no-underline hover:opacity-90 hover:outline-none focus:text-white focus:no-underline focus:opacity-90 focus:outline-none motion-reduce:transition-none"
  type="button"
  data-te-target="#carouselExampleCaptions"
  data-te-slide="prev">
  <span class="inline-block h-8 w-8">
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="1.5"
      stroke="currentColor"
      class="h-6 w-6">
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M15.75 19.5L8.25 12l7.5-7.5" />
    </svg>
  </span>
  <span
    class="!absolute !-m-px !h-px !w-px !overflow-hidden !whitespace-nowrap !border-0 !p-0 ![clip:rect(0,0,0,0)]"
    >Previous</span
  >
</button>
<!--Carousel controls - next item-->
<button
  class="absolute bottom-0 right-0 top-0 z-[1] flex w-[15%] items-center justify-center border-0 bg-none p-0 text-center text-white opacity-50 transition-opacity duration-150 ease-[cubic-bezier(0.25,0.1,0.25,1.0)] hover:text-white hover:no-underline hover:opacity-90 hover:outline-none focus:text-white focus:no-underline focus:opacity-90 focus:outline-none motion-reduce:transition-none"
  type="button"
  data-te-target="#carouselExampleCaptions"
  data-te-slide="next">
  <span class="inline-block h-8 w-8">
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="1.5"
      stroke="currentColor"
      class="h-6 w-6">
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M8.25 4.5l7.5 7.5-7.5 7.5" />
    </svg>
  </span>
  <span
    class="!absolute !-m-px !h-px !w-px !overflow-hidden !whitespace-nowrap !border-0 !p-0 ![clip:rect(0,0,0,0)]"
    >Next</span
  >
</button>

    </section>

    <!-- Section "Toutes les équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Toutes les équipes</h2>

      <div class="carousel w-full">
        <div
          v-for="(team, index) in allTeams"
          :key="index"
          :id="'slide' + (index + 1)"
          class="carousel-item relative w-full"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <div class="bg-white p-4 rounded-lg shadow">
              <h3 class="text-lg font-semibold">{{ team.leader }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button
                @click="editTeam(team.id)"
                class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
              >
                Modifier
              </button>
            </div>
            <!-- Add two more grid items for the other team members -->
            <!-- Repeat the structure for the other team members -->
          </div>
          <div
            class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2"
          >
            <a
              :href="
                '#slide' + (index === 0 ? allTeams.length - 1 : index - 1)
              "
              class="btn btn-circle"
              >❮</a
            >
            <a
              :href="
                '#slide' + (index === allTeams.length - 1 ? 0 : index + 1)
              "
              class="btn btn-circle"
              >❯</a
            >
          </div>
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
