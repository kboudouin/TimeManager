<template>
  <div class="container mx-auto py-4">
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>
      <div class="carousel w-full">
        <div v-for="(group, index) in groupedTeams" :key="index" :id="'slide' + (index + 1)" class="carousel-item relative w-full">
          <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <li v-for="team in group" :key="team.id" class="bg-white p-4 rounded-lg shadow">
              <h3 class="text-lg font-semibold">{{ team.name }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button @click="editTeam(team.id)" class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Modifier</button>
            </li>
          </ul>
          <div class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
            <a :href="'#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)" class="btn btn-circle">❮</a>
            <a :href="'#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)" class="btn btn-circle">❯</a>
          </div>
        </div>
      </div>
    </section>

    <!-- Section "Toutes les équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Toutes les équipes</h2>
      <div class="carousel w-full">
        <div v-for="(group, index) in groupedTeams" :key="index" :id="'slide' + (index + 1)" class="carousel-item relative w-full">
          <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <li v-for="team in group" :key="team.id" class="bg-white p-4 rounded-lg shadow">
              <h3 class="text-lg font-semibold">{{ team.name }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button @click="editTeam(team.id)" class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Modifier</button>
            </li>
          </ul>
          <div class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
            <a :href="'#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)" class="btn btn-circle">❮</a>
            <a :href="'#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)" class="btn btn-circle">❯</a>
          </div>
        </div>
      </div>
    </section>
<!-- Section "Créer une nouvelle équipe" -->
<section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Créer une nouvelle équipe</h2>
      <button @click="showCreateTeamForm" class="bg-green-500 text-black py-2 px-4 rounded hover:bg-green-600">Créer une équipe</button>

      <!-- Formulaire de création d'équipe -->
      <div v-if="showCreateTeamForm" class="bg-white p-4 rounded-lg shadow">
        <form @submit.prevent="addTeam">
          <div class="mb-4">
            <label for="teamName" class="block text-black font-semibold">Leader</label>
            <input v-model="newTeam.name" type="text" id="teamName" class="w-full rounded border p-2">
          </div>
          <div class="relative mb-4">
          <label for="teamMembers" class="block text-black font-semibold">Members</label>
          <select v-model="newTeam.members" id="teamMembers" multiple class="w-full rounded border p-2 appearance-none">
    <option v-for="member in availableMembers" :key="member.id" :value="member.id">{{ member.name }}</option>
  </select>
  <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
    <svg class="h-5 w-5 text-gray-400" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" stroke="currentColor" viewBox="0 0 24 24">
      <path d="M19 9l-7 7-7-7"></path>
    </svg>
  </div>
</div>
          <div class="mb-4">
            <label class="block text-black font-semibold">Description de l'équipe</label>
            <textarea class="w-full rounded border p-2"></textarea>
          </div>
          <button @click="API" type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover-bg-blue-600">Créer</button>
        </form>
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
  setup() {
    const teams = [
      { id: 1, name: 'Équipe A', description: 'Description de l\'équipe A' },
      { id: 2, name: 'Équipe B', description: 'Description de l\'équipe B' },
      { id: 3, name: 'Équipe C', description: 'Description de l\'équipe C' },
      // Ajoutez d'autres équipes ici
    ];

    const creatingTeam = ref(false);
    const newTeam = ref({
      name: "",
      description: "",
    });
    const availableMembers = ref([
      { id: 1, name: 'Martin', description: 'Description de l\'équipe A' },
      { id: 2, name: 'Équipe B', description: 'Description de l\'équipe B' },
      { id: 3, name: 'Équipe C', description: 'Description de l\'équipe C' },
    ]);
    const groupedTeams = ref([]);
    

    const showCreateTeamForm = () => {
      creatingTeam.value = true;
      newTeam.value = { name: "", description: "" };
    };

    const addTeam = async () => {
      try {
        const response = await axios.post("http://localhost:4000/api/teams", newTeam.value);

        if (response.status === 201) {
          useToast().success("Équipe ajoutée avec succès.");
          creatingTeam.value = false;
        } else {
          useToast().error("Erreur lors de l'ajout de l'équipe.");
        }
      } catch (error) {
        console.error("Erreur lors de l'ajout de l'équipe", error);
        useToast().error("Erreur lors de l'ajout de l'équipe.");
      }
      
    };

    const API = () => {
      const token = VueCookies.get("token");
      console.log("Récupération de la liste des membres en cours...");
      axios
        .get("http://localhost:4000/api/users", {
          headers: {
            Authorization: `Bearer ${this.token}`,
          },
        })
        .then((response) => {
          console.log("Membres trouvés");
          console.log(response.data);

          if (response.data.users) {
            availableMembers.value = response.data.users; 
            console.log(availableMembers);
          }
        })
        .catch((error) => {
          console.error("Requête API échouée :", error);
        });
    };
    onMounted(() => {
      API();
    });

    return {
      teams,
      creatingTeam,
      newTeam,
      groupedTeams,
      showCreateTeamForm,
      addTeam,
      availableMembers,
    };
  },
};
</script>
