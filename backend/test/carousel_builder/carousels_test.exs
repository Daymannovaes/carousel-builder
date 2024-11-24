defmodule CarouselBuilder.CarouselsTest do
  use CarouselBuilder.DataCase

  alias CarouselBuilder.Carousels

  describe "carousels" do
    alias CarouselBuilder.Carousels.Carousel

    import CarouselBuilder.CarouselsFixtures

    @invalid_attrs %{status: nil, carousel: nil}

    test "list_carousels/0 returns all carousels" do
      carousel = carousel_fixture()
      assert Carousels.list_carousels() == [carousel]
    end

    test "get_carousel!/1 returns the carousel with given id" do
      carousel = carousel_fixture()
      assert Carousels.get_carousel!(carousel.id) == carousel
    end

    test "create_carousel/1 with valid data creates a carousel" do
      valid_attrs = %{status: true, carousel: %{}}

      assert {:ok, %Carousel{} = carousel} = Carousels.create_carousel(valid_attrs)
      assert carousel.status == true
      assert carousel.carousel == %{}
    end

    test "create_carousel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Carousels.create_carousel(@invalid_attrs)
    end

    test "update_carousel/2 with valid data updates the carousel" do
      carousel = carousel_fixture()
      update_attrs = %{status: false, carousel: %{}}

      assert {:ok, %Carousel{} = carousel} = Carousels.update_carousel(carousel, update_attrs)
      assert carousel.status == false
      assert carousel.carousel == %{}
    end

    test "update_carousel/2 with invalid data returns error changeset" do
      carousel = carousel_fixture()
      assert {:error, %Ecto.Changeset{}} = Carousels.update_carousel(carousel, @invalid_attrs)
      assert carousel == Carousels.get_carousel!(carousel.id)
    end

    test "delete_carousel/1 deletes the carousel" do
      carousel = carousel_fixture()
      assert {:ok, %Carousel{}} = Carousels.delete_carousel(carousel)
      assert_raise Ecto.NoResultsError, fn -> Carousels.get_carousel!(carousel.id) end
    end

    test "change_carousel/1 returns a carousel changeset" do
      carousel = carousel_fixture()
      assert %Ecto.Changeset{} = Carousels.change_carousel(carousel)
    end
  end
end
