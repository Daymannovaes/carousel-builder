defmodule CarouselBuilder.SlidesTest do
  use CarouselBuilder.DataCase

  alias CarouselBuilder.Slides

  describe "slides" do
    alias CarouselBuilder.Slides.Slide

    import CarouselBuilder.SlidesFixtures

    @invalid_attrs %{
      position: nil,
      background_color: nil,
      font_color: nil,
      quill_delta_content: nil
    }

    test "list_slides/0 returns all slides" do
      slide = slide_fixture()
      assert Slides.list_slides() == [slide]
    end

    test "get_slide/1 returns the slide with given id" do
      slide = slide_fixture()
      assert Slides.get_slide(slide.id) == slide
    end

    test "create_slide/1 with valid data creates a slide" do
      valid_attrs = %{
        position: 42,
        background_color: "some background_color",
        font_color: "some font_color",
        quill_delta_content: "some quill_delta_content"
      }

      assert {:ok, %Slide{} = slide} = Slides.create_slide(valid_attrs)
      assert slide.position == 42
      assert slide.background_color == "some background_color"
      assert slide.font_color == "some font_color"
      assert slide.quill_delta_content == "some quill_delta_content"
    end

    test "create_slide/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Slides.create_slide(@invalid_attrs)
    end

    test "update_slide/2 with valid data updates the slide" do
      slide = slide_fixture()

      update_attrs = %{
        position: 43,
        background_color: "some updated background_color",
        font_color: "some updated font_color",
        quill_delta_content: "some updated quill_delta_content"
      }

      assert {:ok, %Slide{} = slide} = Slides.update_slide(slide, update_attrs)
      assert slide.position == 43
      assert slide.background_color == "some updated background_color"
      assert slide.font_color == "some updated font_color"
      assert slide.quill_delta_content == "some updated quill_delta_content"
    end

    test "update_slide/2 with invalid data returns error changeset" do
      slide = slide_fixture()
      assert {:error, %Ecto.Changeset{}} = Slides.update_slide(slide, @invalid_attrs)
      assert slide == Slides.get_slide(slide.id)
    end

    test "delete_slide/1 deletes the slide" do
      slide = slide_fixture()
      assert {:ok, %Slide{}} = Slides.delete_slide(slide)
      assert nil == Slides.get_slide(slide.id)
    end

    test "change_slide/1 returns a slide changeset" do
      slide = slide_fixture()
      assert %Ecto.Changeset{} = Slides.change_slide(slide)
    end
  end
end
